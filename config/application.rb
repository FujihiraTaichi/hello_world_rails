require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HelloWorldRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")


    config.generators do |g|
      g.javascripts false
      g.stylesheets false
      g.helper false
      g.template_engine false
      g.test_framework :rspec,
                       fixtures: true,
                       view_spec: false,
                       routing_specs: false,
                       helper_specs: false,
                       controller_specs: false,
                       request_specs: true
    end

    config.api_only = true
    config.middleware.use ActionDispatch::Flash
  end
end
