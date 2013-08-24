require 'boxcar/helpers'

class Boxcar::Core
  class << self
    def unraid?
      `uname -r`.include?('unRAID')
    end
  end
end
