$:.unshift *Dir[File.dirname(__FILE__)]
require "init"

Main.set :run, false

logger = ::File.open("log/main.log", "a+")

Main.use Rack::CommonLogger, logger

run Main
