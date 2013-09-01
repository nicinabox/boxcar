class Main
  module DiskHelpers
    def device_model(disk)
      "Model: " << disk.device_model if disk.device_model
    end

    def serial_number(disk)
      "Serial: " << disk.serial_number if disk.serial_number
    end

    def disk_ids_for_select
      {'' => ''}.merge Boxcar::Array.disk_ids
    end

    def formatted_device(device)
      "(#{device})" unless device.blank?
    end

    def state_icon(disk)
      case disk.state
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
