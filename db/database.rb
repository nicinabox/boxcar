env = ENV['RACK_ENV'] || Main.environment.to_s

db = YAML.load(File.read("config/database.yml"))
ActiveRecord::Base.establish_connection(db[env])
