require 'boxcar/command/base'
require 'boxcar/api/user'
require 'active_record'
require 'db/database'
require 'app/models/user'
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
    users = IniFile.load(users_ini)
    users.to_h.each do |name, user|
      ::User.create!(
        :username    => user['name'],
        :description => user['desc']
      )
    end if users
  end

private

  def users_ini
    '/var/local/emhttp/users.ini'
  end
end
