require 'boxcar/command/base'

# Manage updates for Boxcar
#
class Boxcar::Command::Update < Boxcar::Command::Base
  def index
    version = args.first
    host    = 'https://github.com/nicinabox/boxcar/archive/'
    dest    = 'usr/apps/boxcar'

    # Pack
    FileUtils.cd('/tmp')
    FileUtils.mkdir_p("build/#{dest}")
    `wget -q --no-check-certificate #{host}#{version}.zip`
    `unzip -q #{version}`
    FileUtils.mv("boxcar-#{version}/*", "build/#{dest}")
    FileUtils.mkdir("build/#{dest}/log")
    `makepkg -c y /boot/extra/boxcar-#{version}.txz`

    # Install
    FileUtils.cd('build')
    `installpkg /boot/extra/boxcar-#{version}.txz >/dev/null`
    FileUtils.cd('/tmp')
    FileUtils.rm_rf("build/ boxcar-#{version}/ #{version}")
    FileUtils.ln_s("/#{dest}/bin/boxcar", "/usr/local/sbin/boxcar")
    `export RACK_ENV=production`

    # Bundle & migrate
    FileUtils.cd("/#{dest}")
    `bundle`
    `rake db:migrate RACK_ENV=production >/dev/null`
  end
end
