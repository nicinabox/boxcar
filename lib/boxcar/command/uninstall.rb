require 'boxcar/helpers'
require 'boxcar/command/base'

# Uninstaller for Boxcar
#
class Boxcar::Command::Uninstall < Boxcar::Command::Base
  include Boxcar::Helpers

  def index
    are_you_sure?

    puts `removepkg boxcar-#{::Boxcar::VERSION}`
    `rm /boot/extra/boxcar-#{::Boxcar::VERSION}`
    `rm -rf #{current_path}`

    post_uninstall
  end

  private

  def are_you_sure?
    puts "You're about to uninstall Boxcar. This will remove the Boxcar package from your machine. "
    print "Do you really want to uninstall? (anything other than yes will cancel) "
    remove_boxcar = $stdin.gets.chomp

    if (remove_boxcar == "yes")
      puts "Sorry to see you go."
    else
      abort "Whew! That was close."
    end
  end

  def post_uninstall
    puts <<-OUTPUT.unindent
      Boxcar's dependency packages are listed at: http://boxcar.nicinabox.com/docs/install/
      Remove packages as required.

      Uninstall complete.
    OUTPUT
  end
end