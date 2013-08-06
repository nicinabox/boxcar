require 'boxcar/helpers'

class User
  include Boxcar::Helpers

  def list
    # User with UID >= 100
    users = `awk -F":" '$3 >= 100 { print $1}' /etc/passwd`.strip
    users.split(/\n/)
  end

  def add(user)
    # Add to system
    `useradd -g users -d / -s /bin/false -c '#{user[:description]}' #{user[:username]} |& logger`

    # Change password
    `chpasswd <<< #{user[:username]}:"#{user[:password]}"`

    add_samba_user(user)
    copy_accounts
    update_exports
    kill_networking_services
  end

  def delete(user)
    if user[:username] == "root"
      puts "Cannot delete root user."
      return
    end

    `userdel #{user[:username]}`

    delete_samba_user(user)
    copy_accounts
    update_exports
    kill_networking_services
  end

private

  def add_samba_user(user)
    `smbpasswd -L -s -a #{user[:username]} <<< "#{user[:password]}"$'\n'"#{user[:password]}"`
  end

  def delete_samba_user(user)
    `smbpasswd -x #{user[:username]}`
  end

  def copy_accounts
    # Copy user stuff to /boot/config
    `cp /etc/passwd /etc/shadow /etc/samba/private/smbpasswd /boot/config`
  end

  def kill_networking_services
    # SMB
    `killall -HUP smbd`

    # NFS
    `exportfs -ra |& logger`

    # AFP
    `killall -HUP afpd`
  end

  def update_exports
    `cp /etc/exports- /etc/exports`
    `cp /etc/netatalk/AppleVolumes.default- /etc/netatalk/AppleVolumes.default`
  end
end
