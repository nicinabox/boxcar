db = YAML.load(File.read("config/database.yml"))
RACK_ENV ||= ENV['RACK_ENV'] || "development"
ActiveRecord::Base.establish_connection db[RACK_ENV]
