class Main
  namespace '/disks' do
    before { @title = 'Disks' }

    get '/?' do
      @disks = ::Boxcar::Disk.all
      erb :'disks/index'
    end
  end
end
