# frozen_string_literal: true

source 'https://rubygems.org'

# Ruby version
ruby '2.6.1'

# General list of gems
gem 'active_model_serializers', '~> 0.10.0'
gem 'coffee-rails'
gem 'devise'
gem 'dotenv-rails'
gem 'exponent-server-sdk'
gem 'httparty'
gem 'friendly_id'
gem 'image_processing'
gem 'jbuilder'
gem 'jquery-rails'
gem 'layer-handler'
gem 'mini_magick', '>= 4.3.5'
gem 'mysql2'
gem 'puma'
gem 'pundit'
gem 'rack-cors', require: 'rack/cors'
gem 'rails'
gem 'sass-rails'
gem 'sendgrid'
gem 'shrine'
gem 'turbolinks'
# gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier'
gem 'knock'
# gem 'wicked_pdf'
# gem 'wkhtmltopdf-binary'
gem "active_model_validates_intersection_of"
gem 'ed25519', '~> 1.2'
gem 'bcrypt_pbkdf', '~> 1'
# gem 'mail_form'
gem 'redis'
gem 'redis-namespace'
gem 'redis-rails'
gem 'sidekiq'
gem 'sidekiq-cron'


# Only Development env gems
group :development do
  gem 'foreman'
  gem 'listen'
  gem 'rails_layout'
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
  gem 'spring-commands-rspec'
  gem 'web-console'
  gem 'sidekiq'
  gem 'sidekiq-cron'

  # Guard
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'

  # Spring
  gem 'spring'
  gem 'spring-watcher-listen'

  # Pry
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'

  # Capistrano
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger', '>= 0.1.1'
  # Remove the following if your app does not use Rails
  gem 'capistrano-rails'
  # Remove the following if your server does not use RVM
  gem 'capistrano-db-tasks', require: false
  gem 'capistrano-rbenv'
  gem 'sshkit-sudo'
end

# Only Test env gems
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
end

# Only Production env gems
group :production do
  # gem 'unicorn'
  # gem 'pg'
end

# Both Test and Development env gems
group :development, :test do
  gem 'byebug', platform: :mri
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rubocop'
end
