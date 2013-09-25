ENV['RACK_ENV'] = 'test'

require "pathname"
$:.unshift File.expand_path("../../", Pathname.new(__FILE__).realpath)

require 'rspec'
require 'rr'
require 'sinatra'
require 'config/environment'

def prepare_command(klass)
  klass.new
end

def execute(command_line)
  extend RR::Adapters::RRMethods

  args = command_line.split(" ")
  command = args.shift

  Boxcar::Command.load
  object, method = Boxcar::Command.prepare_run(command, args)

  original_stdin, original_stderr, original_stdout = $stdin, $stderr, $stdout

  $stdin  = captured_stdin  = StringIO.new
  $stderr = captured_stderr = StringIO.new
  $stdout = captured_stdout = StringIO.new
  class << captured_stdout
    def tty?
      true
    end
  end

  begin
    object.send(method)
  rescue SystemExit
  ensure
    $stdin, $stderr, $stdout = original_stdin, original_stderr, original_stdout
    Boxcar::Command.current_command = nil
  end

  [captured_stderr.string, captured_stdout.string]
end

RSpec.configure do |config|
  config.mock_with :rspec
end
