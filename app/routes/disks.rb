class Main
  namespace '/disks' do
    before { @title = 'Disks' }

    get '/?' do
      @disks = ::Boxcar::Disk.all
      temps = @disks.collect { |d| d.temp }
                    .select { |t| t > 42 if t }

      if temps.any?
        flash.now[:danger] = "You have #{temps.count} hot #{pluralize_without_count(temps.count, 'disk')}!"
      end

      erb :'disks/index'
    end
  end
end
