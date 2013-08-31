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
    `cd #{current_path}; thin start -e production -d`
    puts "Boxcar started"
  end

  def stop
    pid = `cd #{current_path}; cat tmp/pids/thin.pid`.chomp
    `kill -9 #{pid}`
    `rm #{current_path}/tmp/pids/thin.pid`
    puts "Boxcar stopped"
  end

  def restart
    stop
    start
  end
end
