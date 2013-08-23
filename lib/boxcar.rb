$:.unshift *Dir[File.dirname('../../')]
$:.unshift *Dir[File.dirname('../../lib')]

require "boxcar/version"
require 'boxcar/cli'

Boxcar::CLI.start(*ARGV)
