require "boxcar/command/base"

class Boxcar::Command::Version < Boxcar::Command::Base
  def index
    puts Boxcar::VERSION
  end

end
