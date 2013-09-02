class Main
  before %r{^(?!\/(javascripts|stylesheets))/} do
  	system = Main.system
  	system.refresh_plugin('uptime', system.os)

    @system = system
  end
end
