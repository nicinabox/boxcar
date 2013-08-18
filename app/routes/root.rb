class Main
  before { @title = 'Dashboard' }

  get '/' do
    erb :'index'
  end
end
