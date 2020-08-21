# frozen_string_literal: true

require 'capistrano-db-tasks'
# config valid for current version and patch releases of Capistrano
lock '~> 3.11.0'

set :application, 'eternity'
set :repo_url, 'git@bitbucket.org:kodelabio/eternity-api.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/joe/myprojects/eternity'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5
# ########capistrano-db-tasks-config##########
# if you want to remove the local dump file after loading
set :db_local_clean, true
# if you want to remove the dump file from the server after downloading
set :db_remote_clean, true
# configure location where the dump file should be created
set :db_dump_dir, -> { File.join(current_path, 'db') }
# If you want to import assets, you can change default asset dir (default = system)
# This directory must be in your shared directory on the server
set :assets_dir, %w[public/uploads]
set :local_assets_dir, %w[public]
# if you are highly paranoid and want to prevent any push operation to the server
set :disallow_pushing, false
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.6.1'

# in case you want to set ruby version from the file:
# set :rbenv_ruby, File.read('.ruby-version').strip

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails]
set :rbenv_roles, :all # default value
# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', '.env')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_ruby, '2.6.1'

namespace :deploy do
  desc 'Upload YAML files.'
  task :upload_yml do
    on roles(:app) do
      execute "mkdir #{shared_path}/config -p"
      upload! StringIO.new(File.read('config/database.yml')), "#{shared_path}/config/database.yml"
      upload! StringIO.new(File.read('config/secrets.yml')), "#{shared_path}/config/secrets.yml"
      upload! StringIO.new(File.read('./.env')), "#{shared_path}/.env" # Uncomment if you have a .env file
    end
  end

  desc 'Initial deploy'
  task :initial do
    before 'deploy:starting', 'deploy:upload_yml'
    before 'deploy:migrate', 'deploy:create_db'
    after 'deploy:migrating', 'deploy:seed_db'
    invoke 'deploy'
  end

  desc 'Creates app database'
  task :drop_db do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rails, 'db:drop'
        end
      end
    end
  end

  desc 'Creates app database'
  task :create_db do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rails, 'db:create'
        end
      end
    end
  end

  desc 'Seeds the database'
  task :seed_db do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rails, 'db:seed'
        end
      end
    end
  end
end

namespace :rails do
  desc 'Open a rails console `cap [staging] rails:console [server_index default: 0]`'
  task :console do
    server = roles(:app)[ARGV[2].to_i]
    puts "Opening a console on: #{server.hostname}...."
    cmd = "ssh #{server.user}@#{server.hostname} -t 'cd #{fetch(:deploy_to)}/current && RAILS_ENV=#{fetch(:rails_env)} bundle exec rails console'"
    puts cmd
    exec cmd
  end
end

# hotfix for ssh agen related issues
task :check_for_ssh_agent do
  pid = ENV['SSH_AGENT_PID']
  raise %|No ssh-agent active (cannot authenticate to bitbucket without it.) Try running "eval `ssh-agent`; ssh-add".| if pid.nil? || (pid == '') || (pid.to_i == 0)

  begin
    Process.getpgid(pid.to_i)
  rescue Errno::ESRCH
    raise %|The ssh-agent at pid #{pid} has died (cannot authenticate to bitbucket without it.) Try running "eval `ssh-agent`; ssh-add".|
  end

  if /no identities/.match?(`ssh-add -L`)
    raise %(The ssh-agent at pid #{pid} has no keys. Have you run "ssh-add"?)
  end
end
before 'deploy', 'check_for_ssh_agent'

set :passenger_restart_with_touch, true
set :deploy_via, :remote_cache
