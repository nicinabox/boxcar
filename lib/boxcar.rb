require 'pathname'
$:.unshift File.expand_path("../../lib", Pathname.new(__FILE__).realpath)

require "boxcar/version"
require 'boxcar/cli'

Boxcar::CLI.start(*ARGV)