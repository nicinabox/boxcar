class Main
  namespace '/addons' do
    before { @title = 'Addons' }

    get '/?' do
      erb :'addons/index'
    end

    get '.json' do
      addons_host = 'http://boxcar-addons.herokuapp.com'
      response = HTTParty.get("#{addons_host}/addons.json")
      response.body
    end
  end
end
