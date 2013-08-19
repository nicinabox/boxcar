require 'boxcar/helpers'
require 'boxcar/command/base'

# Manage Boxcar server
#
class Boxcar::Command::Server < Boxcar::Command::Base
  include Boxcar::Helpers

  def index
    validate_arguments!
  end

  def start
    `cd #{current_path}; rackup -P /tmp/boxcar.pid -D -E production`
    puts "Boxcar started"
  end

  def stop
    pid = `cat /tmp/boxcar.pid`.chomp
    `kill -9 #{pid}`
    `rm /tmp/boxcar.pid`
    puts "Boxcar stopped"
  end

  def restart
    stop
    start
  end
end
