require 'boxcar/command/base'
require 'httparty'

# Manage updates for Boxcar
#
class Boxcar::Command::Update < Boxcar::Command::Base
  include HTTParty

  # update
  #
  # Update Boxcar
  # update <optional-version>
  #
  # If version is not specified, latest stable will be used
  def index
    # We need to handle a few cases:
    # 1. no version (use latest)
    # 2. exact version
    # 3. branch (master, or other)

    version = shift_argument || latest_stable

    unless all_versions.include? version
      puts "Latest stable version: #{latest_stable}"
      abort "Requested version (#{version}) not found"
    end

    if version == Boxcar::VERSION
      abort "You're already on #{version}"
    end

    `boxcar server:stop`

    puts "Fetching..."
    FileUtils.cd('/tmp') do
      # Fetch
      FileUtils.mkdir_p("build/#{dest}/log")
      `wget -q --no-check-certificate #{host}#{version}.zip`
      `unzip -q #{version}`
      `mv boxcar-#{version}/* build/#{dest}`
      `mv build/#{dest}/boot build/`
      `rm -rf build/#{dest}/test`
    end

    puts "Precompiling assets..."
    FileUtils.cd("/tmp/build/#{dest}") do
      # Precompile
      `bundle && rake assetpack:build`
    end

    FileUtils.cd('/tmp/build') do
      puts "Packing..."
      `rm /boot/extra/boxcar-*`
      `makepkg -c y /boot/extra/boxcar-#{version}.txz`

      puts "Installing..."
      `installpkg /boot/extra/boxcar-#{version}.txz >/dev/null`
    end

    FileUtils.cd('/tmp') do
      puts "Clean up..."
      FileUtils.rm_rf(%W(build boxcar-#{version} #{version}))
    end

    # Migrate
    puts "Finishing..."
    FileUtils.cd("/#{dest}") do
      `rake db:migrate RACK_ENV=production >/dev/null`

      puts "Updated to #{version}!"
    end

    track_event("CLI", "update", version)

    `boxcar server:start`
  end

private

  def host
    'https://github.com/nicinabox/boxcar/archive/'
  end

  def dest
    'usr/apps/boxcar'
  end

  def latest_stable
    all_tags.first
  end

  def all_tags
    response = self.class.get('https://api.github.com/repos/nicinabox/boxcar/tags')
    tags = JSON.parse(response.body)
    tags.collect { |t| t['name'] }
  end

  def all_branches
    response = self.class.get('https://api.github.com/repos/nicinabox/boxcar/branches')
    branches = JSON.parse(response.body)
    branches.collect { |b| b['name'] }
  end

  def all_versions
    all_branches.concat(all_tags)
  end
end
