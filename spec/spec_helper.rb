ENV['RACK_ENV'] = 'test'

require "pathname"
$:.unshift File.expand_path("../../", Pathname.new(__FILE__).realpath)

require 'sinatra'
require 'config/environment'
