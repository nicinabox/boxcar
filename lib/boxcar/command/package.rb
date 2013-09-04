require 'boxcar/helpers'
require 'boxcar/command/base'
require 'httparty'
require 'json'

# Install Slackware packages
#
class Boxcar::Command::Package < Boxcar::Command::Base
  include Boxcar::Helpers

  def index
    validate_arguments!
  end

  def install
    name    = args[0]
    version = args[1]
    persist = args[3] == "--persist"

    response = HTTParty.get("#{addons_host}/packages/#{name}/#{version}")
    pkg = JSON.parse(response.body)

    if pkg.any?
      pkg = pkg.last
      url = mirror << pkg['path']
    else
      abort "No package #{name}"
    end

    `wget -q #{url}`
    `installpkg #{pkg['package_name']}`
    if persist
      `mv #{pkg['package_name']} /boot/extra/`
    else
      `rm #{pkg['package_name']}`
    end
  end

protected

  def mirror
    'http://slackware.cs.utah.edu/pub/slackware'
  end
end
