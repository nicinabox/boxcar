require 'boxcar/api/disk'
require 'boxcar/api/array'

describe Boxcar::Array do
  describe "#total_size" do
    before(:each) do
      @total_size = Boxcar::Array.total_size
    end

    it "should be 5661141532672 bytes" do
      @total_size.should == 5661141532672
    end
  end
end
