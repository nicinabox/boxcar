namespace '/utilities' do
  before { @title = 'Utilities - Unraid' }
  get do
    erb 'utilities'
  end
end
