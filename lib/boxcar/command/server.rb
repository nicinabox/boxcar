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
    # From emhttp powerdown script
    # Access a blank page in case this is first request since startup.
    `wget -q -O - localhost/update.htm >/dev/null`

    `cd #{current_path}; thin start -e production -d`

    if first_run?
      track_event('CLI', 'install')
      FileUtils.touch('/boot/config/.boxcar')
    end

    puts "Boxcar started"
  end

  def stop
    pid = `cd #{current_path}; cat tmp/pids/thin.pid`.chomp
    `kill -9 #{pid}`
    `rm #{current_path}/tmp/pids/thin.pid`
    puts "Boxcar stopped"
  end

  def tail
    puts `tail -f #{current_path}/log/thin.log`
  end

  def restart
    stop
    start
  end
end
