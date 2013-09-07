ENV['RACK_ENV'] ||= 'development'

root = File.expand_path('..', File.dirname(__FILE__))
$:.unshift *Dir[root]

require 'config/environment'
require 'boxcar/version'
require 'boxcar/cli'

Boxcar::CLI.start(*ARGV)
