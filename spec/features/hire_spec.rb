feature 'Hire' do
  scenario 'user books available space' do
    User.create(username: 'Owner', email: 'Owner@yaoogle.com')
    Space.create(title: 'test', description: 'test', price: 10, user_id: 1)
    sign_up
    hire
    expect{ hire }.to change { Hire.count }.by 1
    expect(Hire.first.date).to eq('02/01/2109')
    expect(Hire.first.user_id).to eq(2)
    expect(Hire.first.space_id).to eq(1)
  end
end

  def hire
    visit '/hire/new'
    fill_in :date, with: '02/01/2109'
    click_button 'Hire Space'
  end

