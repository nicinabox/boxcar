require 'boxcar/helpers'
require 'optparse'

module Boxcar
  module Command
    extend Boxcar::Helpers

    def self.load
      Dir[File.join(File.dirname(__FILE__), "command", "*.rb")].each do |file|
        require file
      end
    end

    def self.prepare_run(cmd, args=[])
      command = parse(cmd)

      @current_command = cmd
      @anonymized_args, @normalized_args = [], []

      opts = {}
      invalid_options = []

      if command
        command_instance = command[:klass].new(args.dup, opts.dup)

         @normalized_command = [ARGV.first, @normalized_args.sort_by {|arg| arg.gsub('-', '')}].join(' ')

        [ command_instance, command[:method] ]
      else
        error([
          "`#{cmd}` is not a boxcar command.",
          "See `boxcar help` for a list of available commands."
        ].compact.join("\n"))
      end

    end

    def self.run(cmd, arguments=[])
      object, method = prepare_run(cmd, arguments.dup)
      object.send(method)
    end

    def self.commands
      @@commands ||= {}
    end

    def self.namespaces
      @@namespaces ||= {}
    end

    def self.register_command(command)
      commands[command[:command]] = command
    end

    def self.register_namespace(namespace)
      namespaces[namespace[:name]] = namespace
    end

    def self.command_aliases
      @@command_aliases ||= {}
    end

    def self.files
      @@files ||= Hash.new {|hash,key| hash[key] = File.readlines(key).map {|line| line.strip}}
    end

    def self.parse(cmd)
      commands[cmd] || commands[command_aliases[cmd]]
    end
  end
end
