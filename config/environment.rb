require 'sinatra'

configure :production do
  set :addons_host, "http://addons.boxcar.nicinabox.com"
end

configure :development do
  set :addons_host, "http://localhost:4568"
  enable :show_exceptions
end
