namespace '/disks/?' do
  before { @title = 'Disks' }

  get do
    erb 'disks/index'
  end
end
