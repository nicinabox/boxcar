$:.unshift *Dir[File.expand_path('.')]
$:.unshift *Dir[File.expand_path('../lib')]

require "boxcar/version"
require 'boxcar/cli'

Boxcar::CLI.start(*ARGV)
