# frozen_string_literal: true

source 'https://rubygems.org'

gem 'bcrypt', '3.1.12'
gem 'bootstrap', '~> 4.1.1'
gem 'cancancan'
gem 'carrierwave', '1.1.0'
gem 'coffee-rails', '4.2.2'
gem 'devise'
gem 'dotenv-rails'
gem 'factory_bot_rails'
gem 'jbuilder', '2.7.0'
gem 'jquery-rails', '4.3.1'
gem 'mini_magick', '4.7.0'
gem 'mysql2', '>= 0.5.3'
gem 'puma', '3.9.1'
gem 'rails', '5.1.6'
gem 'sass-rails', '5.0.6'
gem 'turbolinks', '5.0.1'
gem 'uglifier', '3.2.0'

gem 'fog-aws'
gem 'kaminari'
gem 'ransack'
gem 'ratyrate'
gem 'rmagick'
gem 'sendgrid-ruby'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capistrano'
  gem 'capistrano3-unicorn'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capybara', '>= 2.15'
  gem 'pry-byebug'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end

group :development do
  gem 'listen', '3.1.5'
  gem 'pry-byebug'
  gem 'spring', '2.0.2'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'web-console', '3.5.1'
end

group :production do
  # gem 'pg', '0.20.0'
  gem 'rails_12factor', '0.0.2'
  gem 'unicorn', '5.4.1'
end

# Windows環境ではtzinfo-dataというgemを含める必要があります
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
