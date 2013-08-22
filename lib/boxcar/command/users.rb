require 'boxcar/command/base'
require 'boxcar/api/user'
require 'inifile'

# Manage users
#
class Boxcar::Command::Users < Boxcar::Command::Base

  # users
  #
  # List user accounts
  #
  def index
    validate_arguments!
  end

  def import
    users = IniFile.load(users_ini).to_h
    users.each do |name, user|
      User.create!(
        :username => user['name'],
        :description => user['desc']
      )
    end
  end

private

  def users_ini
    '/var/local/emhttp/users.ini'
  end
end
