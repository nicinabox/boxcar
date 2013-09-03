class Main
  namespace '/disks' do
    before { @title = 'Disks' }

    get '/?' do
      @disks = ::Boxcar::Disk.all
      temps = @disks.collect { |d| d.temp }.compact

      if temps.select { |t| t > danger_temp if t }.any?
        flash.now[:danger] = "You have #{temps.count} hot #{pluralize_without_count(temps.count, 'disk')}!"
      elsif temps.select { |t| t.between? warning_temp, danger_temp if t }.any?
        flash.now[:warning] = "You have #{temps.count} warm #{pluralize_without_count(temps.count, 'disk')}."
      end

      erb :'disks/index'
    end
  end
end
