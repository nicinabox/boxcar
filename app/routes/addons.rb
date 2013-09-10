class App
  namespace '/addons' do
    before {
      @title = 'Addons'
    }

    get '/?' do
      erb :'addons/index'
    end

    get '.json' do
      response = HTTParty.get("#{addons_host}/addons.json")
      response.body
    end
  end
end
