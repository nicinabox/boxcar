namespace '/shares' do
  before { @title = 'Shares' }
  get do
    erb 'shares'
  end
end
