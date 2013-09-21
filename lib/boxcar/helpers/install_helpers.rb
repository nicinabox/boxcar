module Boxcar
  module InstallHelpers
    def fetch_archive
      FileUtils.cd('/tmp') do
        `wget -q --no-check-certificate #{host}#{version}.zip`
        `unzip -q #{version}`
      end
    end

    def map_files
      FileUtils.cd('/tmp') do
        install_map = YAML.load_file("/tmp/boxcar-#{version}/config/install_map.yml")
        install_map.each do |target_dir, files|
          relative_target_dir = target_dir.gsub(/^\//, '')

          FileUtils.mkdir_p("build/#{relative_target_dir}")

          files.each do |file|
            `mv boxcar-#{version}/#{file} build/#{relative_target_dir}`
          end

        end

      end
    end

    def bundle_and_precompile
      FileUtils.cd("/tmp/build/#{dest}") do
        `bundle && rake assetpack:build`
      end
    end

    def pack_and_install
      FileUtils.cd('/tmp/build') do
        puts "Packing..."
        `rm /boot/extra/boxcar-*`
        `makepkg -c y /boot/extra/boxcar-#{version}.txz`

        puts "Installing..."
        `installpkg /boot/extra/boxcar-#{version}.txz >/dev/null`
      end
    end

    def remove_tmp_dirs
      puts "Clean up..."
      FileUtils.cd('/tmp') do
        FileUtils.rm_rf(%W(build boxcar-#{version} #{version}))
      end
    end

    def run_migrations
      puts "Finishing..."
      FileUtils.cd("/#{dest}") do
        `rake db:migrate RACK_ENV=production >/dev/null`
      end
    end

    def symlink_command
      `ln -s /usr/apps/boxcar/bin/boxcar /usr/local/bin/boxcar`
    end

    def host
      'https://github.com/nicinabox/boxcar/archive/'
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
