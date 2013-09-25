source 'https://rubygems.org'

# Sinatra microframework
gem "sinatra", require: "sinatra/base"

# Sinatra extensions
gem 'sinatra-contrib', require: %w(
  sinatra/namespace
  sinatra/content_for
)

gem "sinatra-support", "~> 1.2.0",
  require: "sinatra/support"

gem "sinatra-assetpack",
  require: "sinatra/assetpack"

gem 'sinatra-routing-helpers',
  require: "sinatra/routing-helpers"

gem 'sinatra-tag-helpers',
  require: "sinatra/tag-helpers"

gem 'sinatra-partial',
  require: 'sinatra/partial'

group :test do
  gem 'rspec'
  gem 'rr'
end

gem 'rack-flash3', require: 'rack-flash'
gem 'ohai', require: 'ohai'
gem 'gabba'
gem 'thin'
gem 'inifile'
gem "rtopia", "~> 0.2.3"
gem "jsmin", "~> 1.0.1"
gem 'httparty'
gem 'grit'
gem 'crack'
gem 'sqlite3'
gem 'rack-compatible'
gem 'erubis'
gem 'escape_utils', :require => %w(
  escape_utils
  escape_utils/html/erb
  escape_utils/html/rack
  escape_utils/url/erb
  escape_utils/url/rack
  escape_utils/url/uri
)

group :development do
  gem "pistol", "~> 0.0.2"
end

group :assets do
  gem 'compass', '~> 0.12'
end
