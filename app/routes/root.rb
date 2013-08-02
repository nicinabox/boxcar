namespace '/' do
  before { @title = 'Dashboard - Unraid' }
  get do
    erb 'index'
  end
end
