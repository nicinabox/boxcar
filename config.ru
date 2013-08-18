root = File.join(File.dirname(__FILE__)
require "#{root}/init"

Main.set :run, false

logger = ::File.open("log/main.log", "a+")

Main.use Rack::CommonLogger, logger

run Main
