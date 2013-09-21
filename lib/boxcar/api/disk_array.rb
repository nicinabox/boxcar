require 'boxcar/api/disk'
require 'boxcar/api/smart'
require 'inifile'

class Boxcar::DiskArray < Boxcar::Disk
  extend Boxcar::Smart

  def self.start
    system '/root/mdcmd start'
  end

  def self.stop
    system '/root/mdcmd stop'
  end

  def total_size
    disks = self.class.all.reject { |disk| disk.flash? }
    disks.map(&:size).inject(0, &:+)
  end

  def usable_size
    disks = self.class.all.reject { |disk| disk.special? }
    disks.map(&:size).inject(0, &:+)
  end

  def parity_size
    self.class.find('parity').size
  end

  def cache_size
    self.class.find('cache').size
  end

  def usable_free_space
    disks = self.class.all.reject { |disk| disk.special? }
    disks.map(&:free).inject(0, &:+)
  end

  def usable_used_space
    usable_size - usable_free_space
  end

  def started?
    status == 'STARTED'
  end

private

  def status
    return unless unraid?
    status = IniFile.new(`/root/mdcmd status`)
    status['global']['mdState']
  end
end
