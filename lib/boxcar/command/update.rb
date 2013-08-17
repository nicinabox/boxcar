require 'boxcar/command/base'

# Manage updates for Boxcar
#
class Boxcar::Command::Update < Boxcar::Command::Base
  def index
    validate_arguments!
  end
end
