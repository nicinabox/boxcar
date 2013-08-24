class Main
  namespace '/array' do

    post '/start/?' do
      unless ::Boxcar::Array.start
        halt 500
      end
    end

    post '/stop/?' do
      unless ::Boxcar::Array.stop
        halt 500
      end
    end

  end
end
