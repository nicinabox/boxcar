class Main
  module DiskHelpers
    def size(disk)
      humanize_size to_bytes disk[1]['sizeSb'] || disk[1]['fsSize']
    end

    def temp(disk)
      temp = disk[1]['temp']
      temp unless temp == "*"
    end

    def device(disk)
      device = disk[1]['device']
      "(#{device})" unless device.blank?
    end

    def state(disk)
      ::Boxcar::Disk.color_to_state disk[1]['color']
    end

    def spinning?(disk)
      state(disk) != "not-spinning"
    end

    def state_icon(disk)
      case state(disk)
      when 'normal'
        '<i class="icon-refresh" data-toggle="tooltip" title="Disk is spinning"></i>'
      when 'invalid'
        '<i class="icon-warning-sign" data-toggle="tooltip" title="Disk is invalid"></i>'
      when 'disabled'
        '<i class="icon-ban-circle" data-toggle="tooltip" title="Disk is disabled"></i>'
      when 'new'
        '<i class="icon-hdd" data-toggle="tooltip" title="Disk is new"></i>'
      when 'unassigned'
        '<i class="icon-wrench" data-toggle="tooltip" title="Disk is not assigned"></i>'
      end
    end
  end

  helpers DiskHelpers
end
