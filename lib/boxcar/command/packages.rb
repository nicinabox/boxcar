require 'boxcar/helpers'
require 'boxcar/command/base'
require 'httparty'
require 'json'

# Manage Slackware packages
#
class Boxcar::Command::Packages < Boxcar::Command::Base
  include Boxcar::Helpers

  def index
    validate_arguments!
  end

  # packages:install
  #
  # Add Slackware package
  #
  # -p, --persist         # Save to /boot/extra
  # -v, --version VERSION # Specify an exact version
  #
  # Example:
  # $ boxcar packages:install NAME [-v VERSION, -p]
  #
  # If version is not specified, latest available will be used
  #
  def install
    name = shift_argument

    response = HTTParty.get("#{addons_host}/packages/#{name}/#{options[:version]}")
    pkg = JSON.parse(response.body)

    if pkg.any?
      pkg = pkg.last
      url = mirror << pkg['path']
    else
      abort "No package #{name}"
    end

    `wget -q #{url}`
    puts `installpkg #{pkg['package_name']}`
    if options[:persist]
      `mv #{pkg['package_name']} /boot/extra/`
    else
      `rm #{pkg['package_name']}`
    end
  end

  alias_command "packages:add", "packages:install"

protected

  def mirror
    'http://slackware.cs.utah.edu/pub/slackware'
  end
end
