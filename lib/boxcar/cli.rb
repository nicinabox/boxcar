require 'boxcar/command'

class Boxcar::CLI
  def self.start(*args)
    command = args.shift.strip rescue "help"

    Boxcar::Command.load
    Boxcar::Command.run(command, args)
  end
end
