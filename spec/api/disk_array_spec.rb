require 'boxcar/api/disk_array'

describe Boxcar::DiskArray do
  before(:each) do
    @disk_array = Boxcar::DiskArray.new
  end

  describe "#total_size" do
    it "should be 5661141532672 bytes" do
      expect(@disk_array.total_size).to eq 5661141532672
    end
  end

  describe "#usable_size" do
    it "should be 3500700778496 bytes" do
      expect(@disk_array.usable_size).to eq 3500700778496
    end
  end

  describe "#parity_size" do
    it "should be 2000398901248 bytes" do
      expect(@disk_array.parity_size).to eq 2000398901248
    end
  end

  describe "#cache_size" do
    it "should be 160041852928 bytes" do
      expect(@disk_array.cache_size).to eq 160041852928
    end
  end

  describe "#usable_free_space" do
    it "should be 1927230152704 bytes" do
      expect(@disk_array.usable_free_space).to eq 1927230152704
    end
  end

  describe "#usable_used_space" do
    it "should be 1573470625792 bytes" do
      expect(@disk_array.usable_used_space).to eq 1573470625792
    end
  end

  describe "#started?" do
    it "should be true" do
      @disk_array.stub(:status).and_return('STARTED')

      expect(@disk_array.started?).to be true
    end
  end
end
