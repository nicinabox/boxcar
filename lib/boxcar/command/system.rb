require 'boxcar/command/base'
require 'boxcar/api/system'

# Display system information
#
class Boxcar::Command::System < Boxcar::Command::Base

  # system
  #
  # Report system information
  #
  def index
    validate_arguments!
  end

  # system:uptime
  #
  # Display system uptime
  #
  def uptime
    puts System.new.uptime
  end

  # system:cpu
  #
  # CPU information
  #
  def cpu
    puts System.new.cpu
  end
end
