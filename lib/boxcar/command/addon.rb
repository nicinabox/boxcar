require 'boxcar/helpers'
require 'boxcar/command/base'
require 'grit'
require 'httparty'

# Manage unRAID Addons
#
class Boxcar::Command::Addon < Boxcar::Command::Base
  include Boxcar::Helpers
  include Grit
  include HTTParty

  def index
    validate_arguments!
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
    version = boxcar_json(name, url)

    response = HTTParty.post("#{addons_host}/addons",
                              :query => {
                                :addon => {
                                  :name     => name,
                                  :endpoint => url,
                                },
                                :version => version
                              })

    messages = JSON.parse(response.parsed_response)
    errors = messages["errors"]

    if errors
      puts errors.join('\n')
    else
      puts messages["success"]
    end

  end

private

  def boxcar_json(name, url)
    dest = "/tmp/#{name}"
    metadata = dest + "/boxcar.json"

    repo = Git.new(dest)
    repo.clone({
        :quiet => true
      },
      url,
      dest
    )

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
