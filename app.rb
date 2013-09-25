ENV['RACK_ENV'] ||= 'development'
$:.unshift *Dir["./lib"]

# Bundler
require "bundler"
Bundler.require(:default, :assets, ENV['RACK_ENV'].to_sym)

class App < Sinatra::Base
  register Sinatra::Namespace
  register Sinatra::Partial
  use Rack::Flash

  set      :bind, '0.0.0.0'
  set      :root, lambda { |*args| File.join(File.dirname(__FILE__), *args) }
  set      :run,  lambda { __FILE__ == $0 and not running? }
  set      :views, root('app', 'views')
  set      :default_builder, 'StandardFormBuilder'

  enable   :sessions
  enable   :raise_errors, :sessions, :logging

  set      :partial_template_engine, :erb
  enable   :partial_underscores
end

# Load files
(Dir['./config/defaults/*.rb'].sort +
 Dir['./config/*.rb'].sort +
 Dir['./app/init/*.rb'].sort +
 Dir['./lib/boxcar/version.rb'].sort +
 Dir['./lib/boxcar/api/*.rb'].sort +
 Dir['./app/**/*.rb'].sort
).uniq.each { |rb| require rb }

# Start app
App.set :system, Boxcar::System.new
App.set :disk_array, Boxcar::DiskArray.new

App.set :port, ENV['PORT'].to_i  if ENV['PORT']
App.send :include, Boxcar
App.send :include, Boxcar::Helpers

App.run!  if App.run?
