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

    def spinning_icon(disk)
      '<i class="icon-refresh" data-toggle="tooltip" title="Disk is spinning"></i>' if spinning?(disk)
    end
  end

  helpers DiskHelpers
end
