require 'boxcar/helpers'
require 'boxcar/command/base'

# List commands and display help
#
class Boxcar::Command::Help < Boxcar::Command::Base
  include Boxcar::Helpers

  PRIMARY_NAMESPACES = %w( addons server update )

  # help [COMMAND]
  #
  # list available commands or display help for a specific command
  #
  def index
    if command = args.shift
      help_for_command(command)
    else
      help_for_root
    end
  end

  def commands
    Boxcar::Command.commands
  end

  def self.groups
    @groups ||= []
  end

  def primary_namespaces
    PRIMARY_NAMESPACES.map { |name| namespaces[name] }.compact
  end

private
  def skip_command?(command)
    return true if command[:help] =~ /DEPRECATED:/
    return true if command[:help] =~ /^ HIDDEN:/
    false
  end

  def commands_for_namespace(name)
    Boxcar::Command.commands.values.select do |command|
      command[:namespace] == name && command[:command] != name
    end
  end

  def namespaces
    namespaces = Boxcar::Command.namespaces
    namespaces.delete("app")
    namespaces
  end

  def help_for_namespace(name)
    namespace_commands = commands_for_namespace(name)

    unless namespace_commands.empty?
      size = longest(namespace_commands.map { |c| c[:banner] })
      namespace_commands.sort_by { |c| c[:banner].to_s }.each do |command|
        next if skip_command?(command)
        command[:summary] ||= legacy_help_for_command(command[:command])
        puts "  %-#{size}s  # %s" % [ command[:banner], command[:summary] ]
      end
    end
  end

  def legacy_help_for_namespace(namespace)
    instance = Boxcar::Command::Help.groups.map do |group|
      [ group.title, group.select { |c| c.first =~ /^#{namespace}/ }.length ]
    end.sort_by { |l| l.last }.last
    return nil unless instance
    return nil if instance.last.zero?
    instance.first
  end

  def legacy_help_for_command(command)

    Boxcar::Command::Help.groups.each do |group|
      group.each do |cmd, description|
        return description if cmd.split(" ").first == command
      end
    end
    nil
  end

  def help_for_command(name)
    if command_alias = Boxcar::Command.command_aliases[name]
      display("Alias: #{name} redirects to #{command_alias}")
      name = command_alias
    end
    if command = commands[name]
      puts "Usage: boxcar #{command[:banner]}"

      if command[:help].strip.length > 0
        help = command[:help].split("\n").reject do |line|
          line =~ /HIDDEN/
        end
        puts help[1..-1].join("\n")
      else
        puts
        puts " " + legacy_help_for_command(name).to_s
      end
      puts
    end

    namespace_commands = commands_for_namespace(name).reject do |command|
      command[:help] =~ /DEPRECATED/
    end

    if !namespace_commands.empty?
      puts "Additional commands, type \"boxcar help COMMAND\" for more details:"
      puts
      help_for_namespace(name)
      puts
    elsif command.nil?
      error "#{name} is not a boxcar command. See `boxcar help`."
    end
  end

  def skip_namespace?(ns)
    return true if ns[:description] =~ /DEPRECATED:/
    return true if ns[:description] =~ /HIDDEN:/
    false
  end

  def additional_namespaces
    (namespaces.values - primary_namespaces)
  end

  def summary_for_namespaces(namespaces)
    size = longest(namespaces.map { |n| n[:name] })
    namespaces.sort_by {|namespace| namespace[:name]}.each do |namespace|
      next if skip_namespace?(namespace)
      name = namespace[:name]
      namespace[:description] ||= legacy_help_for_namespace(name)
      puts "  %-#{size}s  # %s" % [ name, namespace[:description] ]
    end
  end


  def help_for_root
    puts "Usage: boxcar COMMAND [command-specific-options]"
    puts
    puts "Primary help topics, type \"boxcar help TOPIC\" for more details:"
    puts
    summary_for_namespaces(primary_namespaces)
    puts
    puts "Additional topics:"
    puts
    summary_for_namespaces(additional_namespaces)
    puts
  end
end
