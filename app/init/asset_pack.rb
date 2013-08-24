class Main
  register Sinatra::AssetPack

  assets do
    serve '/javascripts', from: 'app/assets/javascripts'
    serve '/stylesheets', from: 'app/assets/stylesheets'

    js :application, '/javascripts/application.js', %w[
      /javascripts/vendor/*.js
      /javascripts/array_controls.js
      /javascripts/confirm.js
      /javascripts/ready.js
    ]

    css :application, %w[
      /stylesheets/application.css
    ]
  end
end
