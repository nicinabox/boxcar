require 'boxcar/command/base'
require 'boxcar/helpers/install_helpers'
require 'httparty'

# Manage updates for Boxcar
#
class Boxcar::Command::Update < Boxcar::Command::Base
  include HTTParty
  include Boxcar::InstallHelpers

  # update
  #
  # Update Boxcar
  # update VERSION
  #
  # If VERSION is not specified, latest stable will be used
  def index
    version = shift_argument || latest_stable

    unless all_versions.include? version
      puts "Latest stable version: #{latest_stable}"
      abort "Requested version (#{version}) not found"
    end

    if version == Boxcar::VERSION
      abort "You're already on #{version}"
    end

    `boxcar server:stop`

    `removepkg boxcar`
    `rm /boot/extra/boxcar*`

    run_installer_without_prompts

    puts "Updated to #{version}!"
    track_event("CLI", "update", version)

    `boxcar server:start`
  end

end
