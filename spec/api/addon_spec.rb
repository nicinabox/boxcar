require 'spec_runner'
require 'boxcar/api/addon'

describe Boxcar::Addon, '.all' do
  it "returns all addons from API as JSON" do
    all_addons = Boxcar::Addon.all
    all_addons.should be_a_kind_of Array
  end
end

describe Boxcar::Addon, '.find' do
  it "returns a single addon from API as JSON" do
    addon = Boxcar::Addon.find('dummy-addon')
    addon.should be_a_kind_of Hash
  end
end
