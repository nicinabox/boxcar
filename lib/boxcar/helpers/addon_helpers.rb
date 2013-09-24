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

  end
end
