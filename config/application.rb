require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Template2
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.generators do |g|
      g.javascripts false
      g.stylesheets false
      g.helper false
      g.template_engine false
      g.test_framework :rspec,
                       view_specs: false,
                       routing_specs: false,
                       helper_specs: false,
                       controller_specs: false,
                       request_specs: true
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.api_only = true
    config.middleware.use ActionDispatch::Flash
  end
end
