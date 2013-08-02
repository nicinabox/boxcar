source 'https://rubygems.org'

group :memcached do
  gem 'dalli', :require => 'rack/session/dalli'
  gem 'kgio'
end

# sinatra
group :sinatra do
  gem 'sinatra'
  gem 'sinatra-partial'
  gem "sinatra-reloader"
  gem 'sinatra-activerecord'
  gem 'sinatra-flash', :require => %w(sinatra/flash)
  gem 'sinatra-tag-helpers', :require => %w(sinatra/tag-helpers)
  gem 'sinatra-routing-helpers', :require => %w(sinatra/routing-helpers)
  gem 'sinatra-contrib', :require => %w(
    sinatra/namespace
    sinatra/content_for
  )
end

group :assorted do
  gem 'sqlite3'
  gem 'activerecord'
  gem 'capistrano'
  gem 'unicorn' # server
  gem 'rack-compatible' # opt into the future
  gem 'rake'
  gem 'pony' # email
  gem 'erubis' # faster better stronger
  gem 'escape_utils', :require => %w(
    escape_utils
    escape_utils/html/erb
    escape_utils/html/rack
    escape_utils/url/erb
    escape_utils/url/rack
    escape_utils/url/uri
  )
end

# assets
group :assets do
  gem 'compass'
  gem 'coffee-script'
end

# sprockets galore
group :sprockets do
  gem 'uglifier'
  gem 'sprockets'
  gem 'sprockets-sass'
  gem 'sprockets-helpers'
end
