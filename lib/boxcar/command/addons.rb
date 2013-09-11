require 'boxcar/helpers'
require 'boxcar/command/base'
require 'boxcar/api/addon'

# Manage unRAID Addons
#
class Boxcar::Command::Addons < Boxcar::Command::Base
  include Boxcar::Helpers
  include Grit
  include HTTParty

  def list
    addons = Boxcar::Addon.all
    puts addons.collect {|a| a['name'] }
  end

  alias_command 'addons', 'addons:list'

  def add
    name = shift_argument
    params = Boxcar::Addon.find(name)
    addon = Boxcar::Addon.new(:name => params['name'],
                              :endpoint => parmas['endpoint'])
    addon.install
  end
end
