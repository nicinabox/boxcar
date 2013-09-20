require 'boxcar/helpers'
require 'httparty'
require 'json'

class Boxcar::Addon
  extend  Boxcar::Helpers
  include Boxcar::Helpers

  def initialize(args = {})
    args.each do |k, v|
      instance_variable_set("@#{k}", v)
    end
  end

  def self.all
    response = HTTParty.get("#{addons_host}/addons.json")
    JSON.parse(response.body)
  end

  def self.find(name)
    response = HTTParty.get("#{addons_host}/addons/#{name}")
    JSON.parse(response.body)
  end

  def install
    puts "Downloading"
    clone_repo @name, @endpoint
    manifest = parse_boxcar_json @name

    puts "Installing dependencies"
    response     = HTTParty.get("#{addons_host}/addons/#{@name}/dependencies")
    dependencies = JSON.parse(response.body)
    dependencies.each do |url|
      download_unless_exists(url)
      installpkg `basename #{url}`
    end

    puts "Packing"
    makepkg @name

    puts "Installing"
    installpkg @name
    remove_repo @name

    # Keep track of what's installed

    puts "Done"
  end

  def remove

  end

end
