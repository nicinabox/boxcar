require 'boxcar/helpers'
require 'inifile'

class Boxcar::Array

  class << self
    include Boxcar::Helpers

    def total_size
      disks = all_disks.reject { |d| /flash/ =~ d }
      sum_disks(disks, 'size')
    end

    def usable_size
      disks = all_disks.reject { |d| /parity|flash/ =~ d }
      sum_disks(disks, 'size')
    end

    def parity_size
      disks = all_disks
      parity = disks['parity']

      to_bytes parity['size']
    end

    def free_space
      disks = all_disks.reject { |d| /parity|flash/ =~ d }
      sum_disks(disks, 'fsFree')
    end

    def used_space
      usable_size - free_space
    end

    def started?
      status == 'STARTED'
    end

    def status
      return unless unraid?
      status = IniFile.new(`/root/mdcmd status`)
      status['global']['mdState']
    end

    def start
      if system '/root/mdcmd start'
        'Array started'
      end
    end

    def stop
      if system '/root/mdcmd stop'
        'Array stopped'
      end
    end

  private

    def all_disks
      @disks ||= Boxcar::Disk.all
    end
  end
end
