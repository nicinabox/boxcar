require 'boxcar/helpers'
require 'inifile'

class Boxcar::Share
  extend Boxcar::Helpers

  attr_accessor :name, :comment

	def self.all
		ini.map { |share|
      new share[1]
    }
	end

  def self.find(name)
    new ini[name]
  end

  def initialize(args = {})
    args.each do |k, v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

end
