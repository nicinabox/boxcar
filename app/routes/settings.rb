class Main
  namespace '/settings' do
    before { @title = 'Settings' }

    get do
      erb :'settings/index'
    end

    get '/:setting/edit' do
      setting = params[:setting].gsub('-', ' ').capitalize
      @title = "Editing #{setting}"

      erb :'settings/edit'
    end
  end
end
