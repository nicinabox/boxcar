class Main
  register Sinatra::AssetPack

  assets do
    serve '/javascripts', from: 'app/assets/javascripts'
    serve '/stylesheets', from: 'app/assets/stylesheets'

    js :application, %w[
      /javascripts/application.js
    ]

    css :application, %w[
      /stylesheets/application.css
    ]
  end
end
