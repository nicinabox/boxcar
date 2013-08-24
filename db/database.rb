env  = ENV['RACK_ENV']

root = File.expand_path('..', File.dirname(__FILE__))
db   = YAML.load_file("#{root}/config/database.yml")

ActiveRecord::Base.establish_connection(db[env])
