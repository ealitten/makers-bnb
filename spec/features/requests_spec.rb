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
end
