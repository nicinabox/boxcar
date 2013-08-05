require "boxcar/command/base"

# Display version
#
class Boxcar::Command::Version < Boxcar::Command::Base
  def index
    puts Boxcar::VERSION
  end

end
