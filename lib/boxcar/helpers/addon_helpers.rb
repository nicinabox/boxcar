module Boxcar
  module AddonHelpers
    def dependencies
      response = HTTParty.get("#{addons_host}/addons/#{@name}/dependencies")
      JSON.parse(response.body)
    end

    def download_unless_exists(url)
      target_dir = '/boot/packages'
      name       = `basename #{url}`.chomp
      target     = "#{target_dir}/#{name}"

      unless File.exists? target
        puts `wget #{url} -P #{target_dir}`
      end
    end

    def move_root_files_to(path)
      tmp_dir  = tmp_repo(@name)
      fullpath = "#{path}/#{@name}"

      FileUtils.cd(tmp_dir) do
        FileUtils.mkdir_p(fullpath)
        root_files = Dir.entries('.').select { |f| !File.directory? f }
        FileUtils.mv root_files, fullpath
      end
    end

  end
end
