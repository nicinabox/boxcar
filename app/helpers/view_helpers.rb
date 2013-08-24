class Main
  module ViewHelpers
    def active_for(path, position = :ends)
      path_match =  case position
                    when :ends
                      /#{path}$/ =~ request.path_info
                    when :starts
                      /^#{path}/ =~ request.path_info
                    when :includes
                      /#{path}/ =~ request.path_info
                    end

      if path_match
        "active"
      end
    end

    def no_results(message)
      erb :'shared/_no_results',
          :locals => { :message => message }
    end

    PREFIX = %W(TB GB MB KB B).freeze
    def humanize_size(s)
      s = s.to_f
      i = PREFIX.length - 1
      while s > 512 && i > 0
        i -= 1
        s /= 1024
      end
      ((s > 9 || s.modulo(1) < 0.1 ? '%d' : '%.1f') % s) + ' ' + PREFIX[i]
    end

    def to_bytes(size)
      size.to_i * 1024
    end
  end

  helpers ViewHelpers
end
