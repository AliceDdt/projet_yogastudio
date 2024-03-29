# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.5'

gem 'active_storage_validations'
gem 'aws-sdk-s3', require: false
gem 'bootsnap', require: false
gem 'clearance'
gem 'enumerize', '~> 2.3', '>= 2.3.1'
gem 'image_processing', '>= 1.2'
gem 'importmap-rails'
gem 'jbuilder'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.2', '>= 7.0.2.2'
gem 'rails-i18n'
gem 'redis', '~> 4.0'
gem 'sassc-rails'
gem 'sqlite3', '~> 1.4'
gem 'stimulus-rails'
gem 'stripe'
gem 'trestle'
gem 'trestle-active_storage', git: 'https://github.com/rzilient-club/trestle-active_storage.git',
                              ref: '3d066c7d2c401d04d12ea346f93e1201c45454b7'
gem 'trestle-auth'
gem 'trestle-search'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'pry', '~> 0.13.1'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'annotate'
  gem 'rails-erd'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'web-console'
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
