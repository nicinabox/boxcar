require 'boxcar/command/base'

class Boxcar::Command::Help < Boxcar::Command::Base
  def index
    puts "Usage: boxcar COMMAND [command-specific-options]"
  end
end
