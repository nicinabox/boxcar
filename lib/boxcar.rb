$:.unshift *Dir[File.expand_path('..', File.dirname(__FILE__))]

require "boxcar/version"
require 'boxcar/cli'

Boxcar::CLI.start(*ARGV)
