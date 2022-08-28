# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Projet
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0


    config.eager_load_paths << Rails.root.join('lib')
    config.autoload_paths += Dir[Rails.root.join('lib').to_s,
                                 Rails.root.join(
                                   'app', 'models', 'concerns'
                                 ).to_s]

    config.i18n.available_locales = %w[en fr]
    config.i18n.default_locale = :fr
    config.i18n.fallbacks = %i[en fr]
    Rails.application.routes.default_url_options[:host] = ENV['BASE_URL']
    config.time_zone = 'Paris'

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
