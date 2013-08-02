namespace '/settings' do
  before { @title = 'Settings - Unraid' }
  get do
    erb 'settings'
  end
end
