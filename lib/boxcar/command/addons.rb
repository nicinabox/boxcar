require 'boxcar/helpers'
require 'boxcar/command/base'
require 'grit'
require 'httparty'
require 'json'

# Manage unRAID Addons
#
class Boxcar::Command::Addons < Boxcar::Command::Base
  include Boxcar::Helpers
  include Grit
  include HTTParty

  def index
    validate_arguments!
  end

  def list
    response = HTTParty.get("#{addons_host}/addons.json")
    addons = JSON.parse(response.body)
    puts addons.collect {|a| a['name'] }
  end

  def add
    name     = shift_argument
    response = HTTParty.get("#{addons_host}/addons/#{name}")
    addon    = JSON.parse response.body

    puts "Downloading"
    clone_repo(addon['name'], addon['endpoint'])

    metadata = parse_boxcar_json(name)
    if metadata['dependencies']
      puts "Fetching dependencies"
    end

    puts "Packing"
    makepkg addon['name']

    puts "Installing"
    installpkg addon['name']
    remove_repo(addon['name'])

    puts "Done"
  end


private

  def clone_repo(name, endpoint)
    dest = tmp_repo(name)

    repo = Git.new(dest)
    repo.clone({
        :quiet => true
      },
      endpoint,
      dest
    )
  end

  def parse_boxcar_json(name)
    dest = tmp_repo(name)
    metadata = dest + "/boxcar.json"

    unless File.exists? metadata
      abort "! No boxcar.json found"
    end

    JSON.parse(File.read(metadata))
  end
end
