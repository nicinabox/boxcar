require 'sinatra'

configure :production do
  set :addons_host, 'http://addons.boxcar.nicinabox.com'
  set :ini_dir,     '/var/local/emhttp'
end

configure :development do
  enable :show_exceptions

  set :addons_host, 'http://localhost:4568'
  set :ini_dir,     'test/files'
end
