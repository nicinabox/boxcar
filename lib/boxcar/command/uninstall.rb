require 'boxcar/command/base'
require 'boxcar/helpers'
require 'boxcar/helpers/install_helpers'

# Uninstaller for Boxcar
#
class Boxcar::Command::Uninstall < Boxcar::Command::Base
  include Boxcar::InstallHelpers
  include Boxcar::Helpers

  # uninstall
  #
  # Remove Boxcar
  def index
    are_you_sure?

    `boxcar stop`

    `removepkg boxcar`
    `rm /boot/extra/boxcar*`
    `rm -rf #{current_path}`

    post_uninstall
  end
end
