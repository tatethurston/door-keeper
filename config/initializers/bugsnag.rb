APP_VERSION = ENV["SOURCE_VERSION"] || ENV["HEROKU_SLUG_COMMIT"]

Bugsnag.configure do |config|
  config.api_key = ENV["BUGSNAG_API_KEY"]
  config.app_version = APP_VERSION
  config.release_stage = ENV["BUGSNAG_RELEASE_STAGE"] || "development"
end
