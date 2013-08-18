Encoding.default_external = 'utf-8'
class Main
  register Sinatra::CompassSupport

  sass_dir = root('app/assets/stylesheets')

  Compass.configuration do |c|
    c.project_path = root
    c.images_dir = "assets/images"
    # c.http_generated_images_path = "/images" # necessary for sprite generation
    # c.http_images_path = "/images"
    c.cache_dir = '../tmp/sass-cache' # optional
    c.sass_options = {
      load_paths: [sass_dir] + Compass.sass_engine_options[:load_paths] } # necessary if using SASS partials
  end
end
