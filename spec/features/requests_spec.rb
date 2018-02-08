feature 'user can view requests' do
  scenario 'user can view requests' do
    sign_up(name: 'Owner', email: 'user1@example.com')
    list_space
    click_button("Sign out")
    sign_up(name: 'Holidaymaker', email: 'user2@example.com')
    visit '/spaces'
    fill_in :date, with: '02/01/2109'
    click_button 'Hire'
    click_button("Sign out")
    login(name: "Owner")
    visit '/requests'
    expect(page).to have_content("You have requests waiting:")
    expect(page).to have_content("2109-01-02")
  end

  scenario 'user has no requests if no listings' do
    sign_up(name: 'Owner', email: 'user1@example.com')
    visit '/requests'
    expect(page).not_to have_content("You have requests waiting:")
  end

  scenario 'user has no requests if none made' do
    sign_up(name: 'Owner', email: 'user1@example.com')
    list_space
    visit '/requests'
    expect(page).not_to have_content("You have requests waiting:")
    expect(page).not_to have_content("2109-01-02")
  end

  scenario 'user can only view requests for their own spaces' do
    sign_up(name: 'Owner', email: 'user1@example.com')
    list_space
    click_button("Sign out")
    sign_up(name: 'Holidaymaker', email: 'user2@example.com')
    visit '/spaces'
    fill_in :date, with: '02/01/2109'
    click_button 'Hire'
    click_button("Sign out")
    sign_up(name: 'Random 3rd party', email: 'user3@example.com')
    visit '/requests'
    expect(page).not_to have_content("You have requests waiting:")
  end



  scenario 'denied requests are no longer shown on the requests page' do
    sign_up(name: 'Owner', email: 'user1@example.com')
    list_space
    click_button("Sign out")
    sign_up(name: 'Holidaymaker', email: 'user2@example.com')
    visit '/spaces'
    fill_in :date, with: '02/01/2109'
    click_button 'Hire'
    click_button("Sign out")
    login(name: "Owner")
    visit '/requests'
    click_button 'Deny'
    expect(page).not_to have_content("You have requests waiting:")
    expect(page).not_to have_content("2109-01-02")
  end

end

feature 'user can accept and deny requests' do
  scenario 'user accepts a request' do
    sign_up(name: 'Owner', email: 'user1@example.com')
    list_space
    click_button("Sign out")
    sign_up(name: 'Holidaymaker', email: 'user2@example.com')
    visit '/spaces'
    fill_in :date, with: '02/01/2109'
    click_button 'Hire'
    click_button("Sign out")
    login(name: "Owner")
    visit '/requests'
    click_button 'Approve'
    expect(page).to have_content("Request approved")
    expect(Hire.first.approved).to eq(true) 
  end

  scenario 'user denies a request' do
    sign_up(name: 'Owner', email: 'user1@example.com')
    list_space
    click_button("Sign out")
    sign_up(name: 'Holidaymaker', email: 'user2@example.com')
    visit '/spaces'
    fill_in :date, with: '02/01/2109'
    click_button 'Hire'
    click_button("Sign out")
    login(name: "Owner")
    visit '/requests'
    click_button 'Deny'
    expect(page).to have_content("Request denied")
    expect(Hire.first.approved).to eq(false) 
  end

end
