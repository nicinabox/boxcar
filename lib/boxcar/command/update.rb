require 'boxcar/command/base'

# Manage updates for Boxcar
#
class Boxcar::Command::Update < Boxcar::Command::Base
  def index
    version = args.first || latest_stable
    abort "You're on the latest stable already" unless version.present?

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
    end

    puts "Precompiling assets..."
    FileUtils.cd("/tmp/build/#{dest}") do
      # Precompile
      `bundle && rake assetpack:build`
    end

    FileUtils.cd('/tmp/build') do
      puts "Packing..."
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

    `boxcar server:start`
  end

private

  def latest_stable
  end
end
