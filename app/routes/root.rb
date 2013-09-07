class App

  get '/' do
    @title = 'Dashboard'
    @stats = {
      :total_size  => ::Boxcar::Array.total_size,
      :parity_size => ::Boxcar::Array.parity_size,
      :cache_size  => ::Boxcar::Array.cache_size,
      :usable_size => ::Boxcar::Array.usable_size,
      :used_space  => ::Boxcar::Array.used_space,
      :free_space  => ::Boxcar::Array.free_space
    }

    @stats.merge!({
      :percent_parity => @stats[:parity_size].to_f / @stats[:total_size].to_f,
      :percent_cache  => @stats[:cache_size].to_f / @stats[:total_size].to_f,
      :percent_free   => @stats[:free_space].to_f / @stats[:usable_size].to_f,
      :percent_used   => @stats[:used_space].to_f / @stats[:usable_size].to_f,
      :percent_used_of_total => @stats[:used_space].to_f / @stats[:total_size].to_f,
      :percent_free_of_total => @stats[:free_space].to_f / @stats[:total_size].to_f
    })

    erb :'index'
  end
end
