module Boxcar
  class App < Sinatra::Application; end

  module Helpers
    extend self

    PREFIX = %W(TB GB MB KB B).freeze

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

    def pluralize_without_count(count, singular)
      count > 1 ? singular.pluralize : singular
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
      App.settings.addons_host
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

    def current_path
      "/usr/apps/boxcar" if unraid?
    end

    def unraid?
      `uname -r`.include?('unRAID')
    end

    def unraid_version
      raw_version = `cat #{App.settings.ini_dir}/var.ini | grep version`
      raw_version.match(/version="(.+)"/) {|m| m[1] if m[1] }
    end

    def parse_ini(file)
      IniFile.load("#{App.settings.ini_dir}/#{file}.ini")
    end

    def ini(file)
      parse_ini(file).to_h
    end

    def to_bytes(size)
      size.to_i * 1024
    end

    def humanize_size(s)
      s = s.to_f
      i = PREFIX.length - 1
      while s > 768 && i > 0
        i -= 1
        s /= 1000
      end
      ((s > 9 || s.modulo(1) < 0.1 ? '%d' : '%.2f') % s) + ' ' + PREFIX[i]
    end

    def sum_disks(disks, method = 'size')
      bytes = disks.map { |d| d.send(method) }
      bytes.compact.inject(:+)
    end

    def number_to_percentage(number, options = { :precision => 0 })
      "%.#{options[:precision]}f" % (number * 100) + '%'
    end

    def number_to_temp(number, options = { :unit => 'C' })
      return if number.blank?
      if options[:unit] == 'F'
        number = convert_c_to_f(number)
      end

      "#{number} #{options[:unit]}"
    end

    def convert_c_to_f(number)
      9 / 5 * (number + 32)
    end

    def first_run?
      not File.exists? '/boot/config/.boxcar'
    end

    def danger_temp
      45
    end

    def warning_temp
      42
    end

  end
end

class String
  def unindent
    gsub(/^#{scan(/^\s*/).min_by{|l|l.length}}/, "")
  end
end
