require 'boxcar/command/base'
require 'boxcar/api/user'

# Manage users
#
class Boxcar::Command::Users < Boxcar::Command::Base

  # users
  #
  # List user accounts
  #
  def index
    validate_arguments!
  end
end
