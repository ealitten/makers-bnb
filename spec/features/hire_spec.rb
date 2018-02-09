feature 'Request' do
  scenario 'user books available space' do
    sign_up(name: 'owner', email: 'owner@example.com')
    list_space
    sign_up(name: 'requester', email: 'requester@example.com')
    expect{ request }.to change { Request.count }.by 1
    expect(Request.first.date.xmlschema).to eq('2018-07-17')
    expect(Request.first.user_id).to eq(2)
    expect(Request.first.space_id).to eq(1)
  end

  scenario 'user cannot book a space which has been booked' do
    sign_up(name: 'owner', email: 'owner@example.com')
    list_space
    click_button 'Sign out'
    sign_up(name: 'requester', email: 'requester@example.com')
    visit('/spaces')
    fill_in 'Date', with: '17/07/2018'
    expect{click_button 'Request'}.to change { Request.count}.by 1
    click_button 'Sign out'
    signin(name: 'owner', password: 'password123')
    click_button 'Requests'
    click_button 'Approve'
    click_button 'Sign out'
    sign_up(name: 'requester2', email: 'requester2@example.com')
    visit('/spaces')
    fill_in 'Date', with: '17/07/2018'
    expect{click_button 'Request'}.to change { Request.count}.by 0
  end

  scenario 'user cannot book a space which is not available' do
    sign_up(name: 'owner', email: 'owner@example.com')
    list_space
    click_button 'Sign out'
    sign_up(name: 'requester', email: 'requester@example.com')
    visit('/spaces')
    fill_in 'Date', with: '17/07/2020'
    expect{click_button 'Request'}.not_to change { Request.count}
  end
end

