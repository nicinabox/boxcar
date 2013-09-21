class App
  namespace '/array' do

    post '/start/?' do
      unless ::Boxcar::DiskArray.start
        halt 500
      end
    end

    post '/stop/?' do
      unless ::Boxcar::DiskArray.stop
        halt 500
      end
    end

  end
end
