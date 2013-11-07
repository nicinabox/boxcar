$:.unshift *Dir[File.dirname(__FILE__)]
require "app"

App.set :run, false

run App
