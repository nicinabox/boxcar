class Main
  register Sinatra::AssetPack

  assets do
    serve '/javascripts', from: 'app/assets/javascripts'
    serve '/stylesheets', from: 'app/assets/stylesheets'
    serve '/images',      from: 'app/assets/images'

    js :application, '/javascripts/application.js', %w[
      /javascripts/vendor/*.js
      /javascripts/disk_assignment.js
      /javascripts/array_controls.js
      /javascripts/system.js
      /javascripts/confirm.js
      /javascripts/addons.js
      /javascripts/ready.js
    ]

    css :application, %w[
      /stylesheets/application.css
    ]
  end
end
