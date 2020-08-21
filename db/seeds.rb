# frozen_string_literal: false

user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email