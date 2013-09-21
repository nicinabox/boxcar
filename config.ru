$:.unshift *Dir[File.dirname(__FILE__)]
require "app"

App.set :run, false

unless File.directory?('log/main.log')
  FileUtils.mkdir_p('log/main.log')
end

logger = ::File.open("log/main.log", "a+")

App.use Rack::CommonLogger, logger

run App
