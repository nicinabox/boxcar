class Boxcar::Command::Base
  def initialize(args=[], options={})
    @args = args
    @options = options
  end

  def self.namespace
    self.to_s.split("::").last.downcase
  end

  def self.extract_help_from_caller(line)
    # pull out of the caller the information for the file path and line number
    if line =~ /^(.+?):(\d+)/
      extract_help($1, $2)
    else
      raise("unable to extract help from caller: #{line}")
    end
  end

  def self.extract_help(file, line_number)
    buffer = []
    lines = Boxcar::Command.files[file]

    (line_number.to_i-2).downto(0) do |i|
      line = lines[i]
      case line[0..0]
        when ""
        when "#"
          buffer.unshift(line[1..-1])
        else
          break
      end
    end

    buffer
  end

  def self.extract_banner(help)
    help.first
  end

  def self.extract_summary(help)
    extract_description(help).split("\n")[2].to_s.split("\n").first
  end

  def self.extract_description(help)
    help.reject do |line|
      line =~ /^\s+-(.+)#(.+)/
    end.join("\n")
  end

  def self.extract_options(help)
    help.select do |line|
      line =~ /^\s+-(.+)#(.+)/
    end.inject([]) do |options, line|
      args = line.split('#', 2).first
      args = args.split(/,\s*/).map {|arg| arg.strip}.sort.reverse
      name = args.last.split(' ', 2).first[2..-1]
      options << { :name => name, :args => args }
    end
  end

  protected

  def self.inherited(klass)
    unless klass == Boxcar::Command::Base
      help = extract_help_from_caller(caller.first)

      Boxcar::Command.register_namespace(
        :name => klass.namespace,
        :description => help.first
      )
    end
  end

  def self.method_added(method)
    return if self == Boxcar::Command::Base
    return if private_method_defined?(method)
    return if protected_method_defined?(method)

    help = extract_help_from_caller(caller.first)
    resolved_method = (method.to_s == "index") ? nil : method.to_s
    command = [ self.namespace, resolved_method ].compact.join(":")
    banner = extract_banner(help) || command

    Boxcar::Command.register_command(
      :klass       => self,
      :method      => method,
      :namespace   => self.namespace,
      :command     => command,
      :banner      => banner.strip,
      :help        => help.join("\n"),
      :summary     => extract_summary(help),
      :description => extract_description(help),
      :options     => extract_options(help)
    )
  end

end
