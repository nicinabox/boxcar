ENV['RACK_ENV'] ||= 'development'

# Bundler
require "bundler"
Bundler.require :default, :assets, ENV['RACK_ENV'].to_sym

# Loadables
# $:.unshift *Dir["./vendor/*/lib"]
$:.unshift *Dir["./lib"]

class Main < Sinatra::Base
  register Sinatra::Namespace
  register Sinatra::Partial
  use Rack::Flash

  set      :bind, '0.0.0.0'
  set      :root, lambda { |*args| File.join(File.dirname(__FILE__), *args) }
  set      :run,  lambda { __FILE__ == $0 and not running? }
  set      :views, root('app', 'views')
  set      :default_builder, 'StandardFormBuilder'
  set      :session_secret, 'ec63ed42f766433b013d172cc7979a6e'

  enable   :sessions
  enable   :raise_errors, :sessions, :logging
  enable   :show_exceptions  if development?

  set      :partial_template_engine, :erb
  enable   :partial_underscores

  use      Rack::Session::Cookie
end

# Load files
(Dir['./config/defaults/*.rb'].sort +
 Dir['./config/*.rb'].sort +
 Dir['./app/init/*.rb'].sort +
 Dir['./lib/boxcar/version.rb'].sort +
 Dir['./lib/boxcar/api/*.rb'].sort +
 Dir['./app/**/*.rb'].sort +
 Dir['./db/database.rb'].sort
).uniq.each { |rb| require rb }

# Start app
Main.set :port, ENV['PORT'].to_i  if ENV['PORT']
Main.run!  if Main.run?
