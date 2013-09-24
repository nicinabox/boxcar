require 'boxcar/helpers'
require 'boxcar/helpers/addon_helpers'
require 'httparty'
require 'json'

class Boxcar::Addon
  extend  Boxcar::Helpers
  include Boxcar::Helpers
  include Boxcar::AddonHelpers

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
    response = HTTParty.get("#{addons_host}/addons/#{name}.json")
    JSON.parse(response.body)
  end

  def install
    # Clone Repo
    clone_repo @name, @endpoint

    # Fetch deps list
    dependencies.each do |url|
      download_unless_exists(url)
      installpkg `basename #{url}`
    end

    # Pack
    makepkg @name

    # Install
    installpkg @name

    # Cleanup
    remove_repo @name

    # Track of what's installed
    @name
  end

end
