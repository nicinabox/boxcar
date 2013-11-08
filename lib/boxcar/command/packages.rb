require 'boxcar/command/base'

# Manage Slackware packages
#
class Boxcar::Command::Packages < Boxcar::Command::Base
  def index
    puts "The packages command has been deprecated. Use trolley instead."
  end
end
