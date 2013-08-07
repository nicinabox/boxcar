require 'boxcar/command/base'
require 'json'
require 'fileutils'
require 'crack'

# Convert exising plugins to Boxcar addon
#
class Boxcar::Command::Convert < Boxcar::Command::Base

  def index
    validate_arguments!
  end

  def plg
    plg     = shift_argument
    file    = File.read plg
    name    = File.basename(plg).gsub(/\.plg$/, '')
    xml     = Crack::XML.parse(file)
    plugin  =  xml['PLUGIN']
    tmp_dir = "/tmp/#{name}"
    deps    = []
    assets  = []

    puts "Converting #{name}..."

    FileUtils.mkdir_p(tmp_dir)

    plugin['FILE'].each do |f|
      # Dependencies
      if f['URL']
        url = extract_dependency(f) || extract_asset(f)
        if url.is_a? String
          deps << url
        else
          assets << url.to_json
        end

      # Installer
      elsif f['Run'] == '/bin/bash'
        write "#{tmp_dir}/install.sh" do
          <<-CODE.unindent
            #!/bin/bash
            #{f['INLINE']}
          CODE
        end

      # Create files
      else
        dest = f['Name']
        puts dest
        FileUtils.mkdir_p(tmp_dir + File.dirname(dest))

        write "#{tmp_dir + dest}" do
          <<-CODE.unindent
            #{f['INLINE']}
          CODE
        end
      end
    end

    write "#{tmp_dir}/boxcar.json" do
      <<-CODE.unindent
      {
        "name": "#{name}",
        "version": "",
        "dependencies": #{deps},
        "assets": #{assets}
      }
      CODE
    end
  end

private

  def extract_dependency(f)
    if /tx|jz$/ =~ f['URL']
      f['URL']
    end
  end

  def extract_asset(f)
    {
      :dest => f['Name'],
      :url  => f['URL']
    }
  end

  def write(file)
    File.open(file, 'w') do |f|
      f.write yield
    end
  end

end
