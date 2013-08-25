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
      FileUtils.mkdir_p("build/#{dest}")
      `wget -q --no-check-certificate #{host}#{version}.zip`

      # Pack
      puts "Packing..."
      `unzip -q #{version}`
      FileUtils.mv("boxcar-#{version}/*", "build/#{dest}")
      FileUtils.mkdir("build/#{dest}/log")
      `makepkg -c y /boot/extra/boxcar-#{version}.txz`

      # Install
      puts "Installing..."
      FileUtils.cd('build')
      `installpkg /boot/extra/boxcar-#{version}.txz >/dev/null`
    end

    FileUtils.cd('/tmp') do
      FileUtils.rm_rf("build/ boxcar-#{version}/ #{version}")
    end

    # Bundle & migrate
    puts "Finishing..."
    FileUtils.ln_s("/#{dest}/bin/boxcar", "/usr/local/sbin/boxcar")
    `export RACK_ENV=production`

    FileUtils.cd("/#{dest}") do
      `bundle`
      `rake db:migrate RACK_ENV=production >/dev/null`

      puts "Updated to #{version}!"
    end

    `boxcar server:start`
  end

private

  def latest_stable
  end
end
