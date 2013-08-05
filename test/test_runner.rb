require 'sinatra'
require 'test/unit'
require "mocha/setup"
require 'rack/test'

set :environment, :test

require "pathname"
$:.unshift File.expand_path("../../lib", Pathname.new(__FILE__).realpath)
