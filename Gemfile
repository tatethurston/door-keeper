source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.0"
gem "rails", "~> 6.0"

gem "bootsnap", ">= 1.4.2", require: false
gem "bugsnag"
gem "devise"
gem "omniauth-google-oauth2"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 4.3.8"
gem "pundit"
gem "paper_trail"
gem "scout_apm"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "dotenv-rails"
  gem "factory_bot_rails"
end

group :development do
  gem "annotate"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end
