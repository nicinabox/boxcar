require 'boxcar/helpers'
require 'inifile'

class Boxcar::Share
  extend Boxcar::Helpers

  attr_accessor :name, :comment

	def self.all
		parse_ini('shares').to_h.map { |share|
      new share[1]
    }
	end

  def initialize(args = {})
    args.each do |k, v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

end
