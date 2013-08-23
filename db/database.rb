env = ENV['RACK_ENV'] || Main.environment.to_s

db = YAML.load_file("config/database.yml")
ActiveRecord::Base.establish_connection(db[env])
