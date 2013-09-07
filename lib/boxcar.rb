ENV['RACK_ENV'] ||= 'development'
ENV['BOXCAR_ROOT'] = File.expand_path('..', File.dirname(__FILE__))

$:.unshift *Dir[ENV['BOXCAR_ROOT']]

require 'config/environment'
require 'boxcar/version'
require 'boxcar/cli'

Boxcar::CLI.start(*ARGV)
