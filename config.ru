$:.unshift *Dir[File.dirname(__FILE__)]
require "app"

App.set :run, false

logger = ::File.open("log/main.log", "a+")

App.use Rack::CommonLogger, logger

run App
