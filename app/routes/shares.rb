class Main
  namespace '/shares' do
    before { @title = 'Shares' }

    # Index
    get '/?' do
      @shares = Share.all
      erb :'shares/index'
    end

    # Edit
    get "/:id/edit/?" do
      @share = Share.find(params[:id])
      @title = "Edit Share"

      erb :'shares/edit'
    end

    # New
    get '/new/?' do
      @title = 'New Share'
      @share = Share.new

      erb :'shares/new'
    end

    # Create
    post '/?' do
      @share = Share.new(params[:share])

      if @share.save
        redirect 'shares'
      else
        erb :'shares/new'
      end
    end

    # Update
    put "/:id/?" do
      @share = Share.find(params[:id])
      if @share.update_attributes(params[:share])
        redirect "shares"
      else
        erb :"shares/edit"
      end
    end

    # Delete
    delete "/:id" do
      @share = Share.find(params[:id]).destroy
      redirect "shares"
    end
  end
end
