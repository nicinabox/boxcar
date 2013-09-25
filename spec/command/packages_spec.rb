require 'boxcar/cli'
require 'boxcar/command/packages'

module Boxcar::Command
  describe Packages do

    describe "find" do
      it "finds available package versions by name" do
        stderr, stdout = execute('packages:find openssl')
        stderr.should == ""
        stdout.should == <<-STDOUT
openssl (1.0.1c, 0.9.8r, 0.9.8n)
STDOUT

      end
    end

  end
end
