class Main
  namespace '/disks' do
    before { @title = 'Disks' }

    get '/?' do
      @disks = Disk.all
      temps = @disks.collect { |d| d.temp }.compact

      dangerous_temps = temps.select { |t| t > danger_temp }
      warning_temps   = temps.select { |t| t.between? warning_temp, danger_temp }

      if dangerous_temps.any?
        flash.now[:danger] = "You have #{dangerous_temps.count} hot #{pluralize_without_count(dangerous_temps.count, 'disk')}!"
      elsif warning_temps.any?
        flash.now[:warning] = "You have #{warning_temps.count} warm #{pluralize_without_count(warning_temps.count, 'disk')}."
      end

      erb :'disks/index'
    end
  end
end
