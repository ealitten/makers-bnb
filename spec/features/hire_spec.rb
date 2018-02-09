feature 'Request' do
  scenario 'user books available space' do
    sign_up(name: 'owner', email: 'owner@example.com')
    Space.create(title: 'test', description: 'test', price: 10, user_id: 1)
    sign_up(name: 'requester', email: 'requester@example.com')
    expect{ request }.to change { Request.count }.by 1
    expect(Request.first.date.xmlschema).to eq('2109-01-02')
    expect(Request.first.user_id).to eq(2)
    expect(Request.first.space_id).to eq(1)
  end

  scenario 'user cannot book a space which has been booked' do
    sign_up(name: 'Client', email: 'Client@example.com')
    Space.create(title: 'test', description: 'test', price: 10, user_id: 3)
    expect{ request }.to change { Request.count }.by 1
    expect{ request }.to change { Request.count }.by 0


  end
end

  def request
    visit '/spaces'
    fill_in :date, with: '02/01/2109'
    click_button 'Request'
  end
