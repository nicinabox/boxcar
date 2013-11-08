module Boxcar
  module InstallHelpers
    def run_installer_without_prompts
      `\\curl -s http://boxcar.nicinabox.com/install | bash -s noprompt`
    end

    def latest_stable
      all_tags.first
    end

    def all_tags
      response = self.class.get('https://api.github.com/repos/nicinabox/boxcar/tags')
      tags = JSON.parse(response.body)
      tags.collect { |t| t['name'] }
    end

    def all_branches
      response = self.class.get('https://api.github.com/repos/nicinabox/boxcar/branches')
      branches = JSON.parse(response.body)
      branches.collect { |b| b['name'] }
    end

    def all_versions
      all_branches.concat(all_tags)
    end

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
end
