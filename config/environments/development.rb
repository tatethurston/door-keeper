Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.log_level = :debug

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Dump schema
  config.active_record.dump_schema_after_migration = true

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
