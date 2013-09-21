require 'boxcar/api/disk'

describe Boxcar::Disk do
  describe '.new' do
    it "creates an instance" do
      @disk = Boxcar::Disk.new({})
      @disk.should be_an_instance_of Boxcar::Disk
    end
  end

  describe ".all" do
    it "returns an array of all disks" do
      @all_disks = Boxcar::Disk.all
      @all_disks.should be_a_kind_of Array
    end
  end

  describe ".find" do
    it "returns a disk by name" do
      @disk = Boxcar::Disk.find('flash')
      @disk.should be_an_instance_of Boxcar::Disk
    end
  end

  describe '#state' do
    it "is active" do
      @disk = Boxcar::Disk.new(color: 'green')
      expect(@disk.state).to eq 'active'
    end

    it "is invalid" do
      @disk = Boxcar::Disk.new(color: 'yellow')
      expect(@disk.state).to eq 'invalid'
    end

    it "is disabled" do
      @disk = Boxcar::Disk.new(color: 'red')
      expect(@disk.state).to eq 'disabled'
    end

    it "is new" do
      @disk = Boxcar::Disk.new(color: 'blue')
      expect(@disk.state).to eq 'new'
    end

    it "is unassigned" do
      @disk = Boxcar::Disk.new(color: 'grey')
      expect(@disk.state).to eq 'unassigned'
    end

    it "is standby" do
      @disk = Boxcar::Disk.new(color: 'green-blink')
      expect(@disk.state).to eq 'standby'
    end
  end

  context "when .active?" do

  end
end
