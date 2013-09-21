require 'sinatra'

configure :production do
  set :addons_host, 'http://addons.boxcar.nicinabox.com'
  set :ini_dir,     '/var/local/emhttp'
end

configure :development, :test do
  enable :show_exceptions

  set :addons_host, 'http://localhost:3000'
  set :ini_dir,     'spec/files'
end
