require 'boxcar/command/base'

class Boxcar::Command::Help < Boxcar::Command::Base
  def index
    puts <<-MSG.unindent
      Usage: boxcar COMMAND [command-specific-options]
    MSG
  end
end
