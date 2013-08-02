namespace '/users' do
  before { @title = 'Users' }

  # Index
  get '/?' do
    @users = User.all
    erb 'users/index'
  end
end
