class Main
  module ViewHelpers
    include ::Boxcar::Helpers

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
  end

  helpers ViewHelpers
end
