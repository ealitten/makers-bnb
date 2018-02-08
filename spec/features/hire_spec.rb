feature 'Hire' do
  scenario 'user books available space' do
    sign_up(name: 'owner', email: 'owner@example.com')
    Space.create(title: 'test', description: 'test', price: 10, user_id: 1)
    sign_up(name: 'hirer', email: 'hirer@example.com')
    expect{ hire }.to change { Hire.count }.by 1
    expect(Hire.first.date.xmlschema).to eq('2109-01-02')
    expect(Hire.first.user_id).to eq(2)
    expect(Hire.first.space_id).to eq(1)
  end

  scenario 'user cannot book a space which has been booked' do
    sign_up(name: 'Client', email: 'Client@example.com')
    Space.create(title: 'test', description: 'test', price: 10, user_id: 3)
    expect{ hire }.to change { Hire.count }.by 1
    expect{ hire }.to change { Hire.count }.by 0


  end
end

  def hire
    visit '/spaces'
    fill_in :date, with: '02/01/2109'
    click_button 'Hire'
  end
