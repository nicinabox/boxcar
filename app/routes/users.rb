namespace '/users' do
  before { @title = 'Users - Unraid' }
  get do
    erb 'users'
  end
end
