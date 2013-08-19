# Connect to database
ENV['RACK_ENV'] ||= 'development'
db = YAML.load(File.read("config/database.yml"))
ActiveRecord::Base.establish_connection db[ENV['RACK_ENV']]
