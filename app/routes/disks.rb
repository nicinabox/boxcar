namespace '/disks' do
  before { @title = 'Disks - Unraid' }
  get do
    erb 'disks'
  end
end
