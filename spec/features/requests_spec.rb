feature 'user can view requests to hire their space' do
  scenario 'user can view requests' do
    sign_up(name: 'Owner', email: 'user1@example.com')
    list_space
    click_button("Sign out")
    sign_up(name: 'Holidaymaker', email: 'user2@example.com')
    visit '/spaces'
    fill_in :date, with: '02/01/2109'
    click_button 'Request'
    click_button("Sign out")
    signin(name: "Owner")
    visit '/requests'
    within 'ul#new_requests' do
      expect(page).to have_content("You have requests waiting:")
      expect(page).to have_content("2109-01-02")
      expect(page).to have_content("Highfield House")
    end
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
    click_button 'Request'
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
    click_button 'Request'
    click_button("Sign out")
    signin(name: "Owner")
    visit '/requests'
    click_button 'Deny'
    expect(page).not_to have_content("You have requests waiting:")
    expect(page).not_to have_content("2109-01-02")
  end

  scenario 'approved requests are still shown on the requests page' do
    sign_up(name: 'Owner', email: 'user1@example.com')
    list_space
    click_button("Sign out")
    sign_up(name: 'Holidaymaker', email: 'user2@example.com')
    visit '/spaces'
    fill_in :date, with: '02/01/2109'
    click_button 'Request'
    click_button("Sign out")
    signin(name: "Owner")
    visit '/requests'
    click_button 'Approve'
    within 'ul#approved_requests' do
      expect(page).to have_content("Approved requests:")
      expect(page).to have_content("2109-01-02")
    end
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
    click_button 'Request'
    click_button("Sign out")
    signin(name: "Owner")
    visit '/requests'
    click_button 'Approve'
    expect(page).to have_content("Request approved")
    expect(Request.first.approved).to eq(true) 
  end

  scenario 'user denies a request' do
    sign_up(name: 'Owner', email: 'user1@example.com')
    list_space
    click_button("Sign out")
    sign_up(name: 'Holidaymaker', email: 'user2@example.com')
    visit '/spaces'
    fill_in :date, with: '02/01/2109'
    click_button 'Request'
    click_button("Sign out")
    signin(name: "Owner")
    visit '/requests'
    click_button 'Deny'
    expect(page).to have_content("Request denied")
    expect(Request.first.approved).to eq(false) 
  end

end

feature 'user can see their requests to hire someone elses space' do
  scenario 'user can view requests' do
    sign_up(name: 'Owner', email: 'user1@example.com')
    list_space
    click_button("Sign out")
    sign_up(name: 'Holidaymaker', email: 'user2@example.com')
    visit '/spaces'
    fill_in :date, with: '02/01/2109'
    click_button 'Request'
    visit '/requests'
    within 'ul#my_requests' do
      expect(page).to have_content("My requests to hire a space:")
      expect(page).to have_content("2109-01-02")
      expect(page).to have_content("Highfield House")
    end
  end
end