require_relative "boot"

require "rails"
require "active_record/railtie"
require "action_controller/railtie"

Bundler.require(*Rails.groups)

module DoorKeeper
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.force_ssl = true if Rails.env.production?

    config.log_level = :info
    # Don't show full error reports.
    config.consider_all_requests_local = false
    # Prepend all log lines with the following tags.
    config.log_tags = [ :request_id ]
    # Print deprecation notices to the Rails logger.
    config.active_support.deprecation = :log

    # Eager load code on boot. This eager loads most of Rails and
    # your application in memory, allowing both threaded web servers
    # and those relying on copy on write to perform better.
    # Rake tasks automatically ignore this option for performance.
    config.eager_load = true
    # Code is not reloaded between requests.
    config.cache_classes = true

    config.middleware.insert_after ActionDispatch::Static, Rack::Deflater

    # https://github.com/plataformatec/devise/issues/4696
    Rails.application.config.middleware.insert_before(
      Warden::Manager, ActionDispatch::Cookies
    )
    Rails.application.config.middleware.insert_before(
      Warden::Manager,
      ActionDispatch::Session::CookieStore,
      key: "#{Rails.application.class.module_parent.name}_#{Rails.env}_session",
      secure: Rails.env.production?
    )

    if !Rails.env.test?
      # Use default logging formatter so that PID and timestamp are not suppressed.
      config.log_formatter = ::Logger::Formatter.new
      logger           = ActiveSupport::Logger.new(STDOUT)
      logger.formatter = config.log_formatter
      config.logger    = ActiveSupport::TaggedLogging.new(logger)
    end
  end
end
