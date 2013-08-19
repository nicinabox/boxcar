db = YAML.load(File.read("config/database.yml"))
ActiveRecord::Base.establish_connection(db[Main.environment.to_s])
