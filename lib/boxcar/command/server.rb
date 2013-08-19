require 'boxcar/command/base'

# Manage Boxcar server
#
class Boxcar::Command::Server < Boxcar::Command::Base
  def index
    validate_arguments!
  end

  def start
    `rackup -P /tmp/boxcar.pid -D`
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
