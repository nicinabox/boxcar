class App
  before %r{^(?!\/(javascripts|stylesheets))/} do
  	system = App.system
  	system.refresh_plugin('uptime', system.os)

    @system = system
  end
end
