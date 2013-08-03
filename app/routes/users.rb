namespace '/users' do
  before { @title = 'Users' }

  # Index
  get '/?' do
    @users = User.all
    erb 'users/index'
  end

  # Edit
  get "/:id/edit/?" do
    @user = User.find(params[:id])
    @title = "Edit User: #{@user.username}"

    erb 'users/edit'
  end

  # New
  get '/new/?' do
    @title = 'New User'
    @user = User.new

    erb 'users/new'
  end

  # Create
  post '/?' do
    @user = User.new(params[:user])

    if @user.save
      redirect 'users'
    else
      erb 'users/new'
    end
  end

  # Update
  put "/:id/?" do
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Saved user #{@user.username} successfully."
      redirect "users"
    else
      erb :"users/edit"
    end
  end

  # Delete
  delete "/:id" do
    @user = User.find(params[:id]).destroy
    redirect "users"
  end

end
