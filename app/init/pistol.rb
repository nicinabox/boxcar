# Pistol auto-reloads your app in development mode.
class App
  configure :development do
    require 'pistol'
    use(Pistol, Dir[root("./{lib,app}/**/*.rb")]) { reset! and load(root('app.rb')) }
  end
end
