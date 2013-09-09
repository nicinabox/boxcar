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
    version = args.first || all_versions[0]
    puts "Latest stable version: #{all_versions[0]}"
    abort "Requested version (#{version}) not found" unless all_versions.include? version
    abort "You're running the requested version (#{version})" if version == Boxcar::VERSION

    host    = 'https://github.com/nicinabox/boxcar/archive/'
    dest    = 'usr/apps/boxcar'

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

  def all_versions
    response = self.class.get('https://api.github.com/repos/nicinabox/boxcar/tags')
    tags = JSON.parse(response.body)
    all_versions = Array.new
    tags.each do |tag|
      all_versions << tag["name"]
    end
    all_versions << "master"
  end
end
