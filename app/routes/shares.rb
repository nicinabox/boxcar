namespace '/shares' do
  before { @title = 'Shares - Unraid' }
  get do
    erb 'shares'
  end
end
