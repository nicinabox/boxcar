class Main
  namespace '/system' do

    post '/reboot' do
      ::Boxcar::System.reboot
    end

    post '/shutdown' do
      ::Boxcar::System.shutdown
    end

  end
end
