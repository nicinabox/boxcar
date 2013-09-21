require 'boxcar/command/base'
require 'boxcar/helpers/install_helpers'
require 'httparty'

# Manage Boxcar installation
#
class Boxcar::Command::Install < Boxcar::Command::Base
  include HTTParty
  include Boxcar::InstallHelpers

  # install
  def index
    fetch_archive
    map_files

    bundle_and_precompile
    pack_and_install
    remove_tmp_dirs
    run_migrations
    symlink_command

    if first_run?
      track_event('CLI', 'install', ::Boxcar::VERSION)
      FileUtils.touch('/boot/config/.boxcar')
    end

    `boxcar server:start`
  end

  # update
  #
  # Update Boxcar
  # update VERSION
  #
  # If VERSION is not specified, latest stable will be used
  def update
    version = shift_argument || latest_stable

    unless all_versions.include? version
      puts "Latest stable version: #{latest_stable}"
      abort "Requested version (#{version}) not found"
    end

    if version == Boxcar::VERSION
      abort "You're already on #{version}"
    end

    `boxcar server:stop`

    fetch_archive
    map_files

    bundle_and_precompile
    pack_and_install
    remove_tmp_dirs
    run_migrations

    puts "Updated to #{version}!"
    track_event("CLI", "update", version)

    `boxcar server:start`
  end

  alias_command 'update', 'install:update'

  # uninstall
  #
  # Remove Boxcar
  def uninstall
    are_you_sure?

    puts `removepkg boxcar-#{::Boxcar::VERSION}`
    `rm /boot/extra/boxcar-#{::Boxcar::VERSION}`
    `rm -rf #{current_path}`

    post_uninstall
  end

  alias_command 'uninstall', 'install:uninstall'
end
