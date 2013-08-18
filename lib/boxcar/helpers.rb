module Boxcar
  module Helpers
    extend self

    def longest(items)
      items.map { |i| i.to_s.length }.sort.last
    end

    def error(message)
      $stderr.puts(format_with_bang(message))
      exit(1)
    end

    def format_with_bang(message)
      return '' if message.to_s.strip == ""
      " !    " + message.split("\n").join("\n !    ")
    end

    def pluralize(count, singular, plural = nil)
      word = if (count == 1 || count =~ /^1(\.0+)?$/)
        singular
      else
        plural || singular.pluralize
      end

      "#{count || 0} #{word}"
    end

    def convert_mhz_to_ghz(frequency)
      speed = frequency.to_f

      if speed > 1000
        (speed / 1000).to_s << " GHz"
      else
        speed << " MHz"
      end
    end

    def addons_host
      if ENV['RACK_ENV'] != "development"
        "http://boxcar-addons.herokuapp.com"
      else
        "http://localhost:4567"
      end
    end

    def tmp_repo(name)
      "/tmp/boxcar/build/#{name}"
    end

    def remove_repo(name)
      FileUtils.rm_rf(tmp_repo(name))
    end

    def makepkg(name)
      if command_exists?('makepkg')
        `makepkg #{name}`
      end
    end

    def installpkg(name)
      if command_exists?('installpkg')
        `installpkg #{name}`
      end
    end

    def command_exists?(command)
      not `command -v #{command}`.empty?
    end
  end
end

class String
  def unindent
    gsub(/^#{scan(/^\s*/).min_by{|l|l.length}}/, "")
  end
end
