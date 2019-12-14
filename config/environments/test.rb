Rails.application.configure do
  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load
  config.cache_classes = false
end
