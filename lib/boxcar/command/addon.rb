require 'boxcar/helpers'
require 'boxcar/command/base'
require 'grit'
require 'httparty'
require 'json'

# Manage unRAID Addons
#
class Boxcar::Command::Addon < Boxcar::Command::Base
  include Boxcar::Helpers
  include Grit
  include HTTParty

  def index
    validate_arguments!
  end

  def list
    response = HTTParty.get("#{addons_host}/addons")
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

  def register
    name, url = args

    unless git_protocol(url)
      puts "! The registry only accepts repos starting with git://"
      abort
    end

    unless repo_public?(url)
      puts "! The package you are trying to register is inaccessible"
      abort
    end

    puts "! Registering a package will make it visible and installable via the registry"
    print "Register #{name}? [yN] "
    register_addon = $stdin.gets.chomp

    abort unless register_addon == 'y'
    clone_repo(name, url)
    metadata = parse_boxcar_json(name)

    response = HTTParty.post("#{addons_host}/addons",
                              :query => {
                                :addon => {
                                  :name     => name,
                                  :endpoint => url,
                                },
                                :version => metadata
                              })

    messages = JSON.parse(response.body)
    errors = messages["errors"]

    if errors
      puts errors.join('\n')
    else
      puts messages["success"]
      remove_repo(name)
    end

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

  def git_protocol(url)
    if /^git:\/\// =~ url
      true
    end
  end

  def repo_public?(url)
    `git ls-remote #{url}`.include? 'master'
  end
end
