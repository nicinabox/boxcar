class App
  before %r{^(?!\/(javascripts|stylesheets))/} do
    system = settings.system
    system.refresh_plugin('uptime', system.os)

    @disk_array = settings.disk_array
    @system = system
  end
end
