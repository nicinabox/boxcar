class App

  get '/' do
    @title = 'Dashboard'
    @stats = {
      :total_size  => @disk_array.total_size,
      :parity_size => @disk_array.parity_size,
      :cache_size  => @disk_array.cache_size,
      :usable_size => @disk_array.usable_size,
      :usable_used_space  => @disk_array.usable_used_space,
      :usable_free_space  => @disk_array.usable_free_space
    }

    @stats.merge!({
      :percent_parity => @stats[:parity_size].to_f / @stats[:total_size].to_f,
      :percent_cache  => @stats[:cache_size].to_f / @stats[:total_size].to_f,
      :percent_free   => @stats[:usable_free_space].to_f / @stats[:usable_size].to_f,
      :percent_used   => @stats[:usable_used_space].to_f / @stats[:usable_size].to_f,
      :percent_used_of_total => @stats[:usable_used_space].to_f / @stats[:total_size].to_f,
      :percent_free_of_total => @stats[:usable_free_space].to_f / @stats[:total_size].to_f
    })

    erb :'index'
  end
end
