require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Shop
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.sass.preferred_syntax = :sass
    config.generators do |g|
      g.cancan :current_ability
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end
  end
end
