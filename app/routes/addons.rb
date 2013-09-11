require 'boxcar/api/addon'

class App
  namespace '/addons' do
    before {
      @title = 'Addons'
    }

    get '/?' do
      erb :'addons/index'
    end

    get '.json' do
      Addon.all.to_json
    end

    post '/install/?' do
      addon = Addon.new(params)
      addon.install
    end

    post '/remove/?' do
      addon = Addon.new(params)
      addon.remove
    end

  end
end
