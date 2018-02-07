feature "sign out" do
  scenario "signs out when user clicks button" do
    create_test_user
    login_test_user
    visit '/spaces'
    click_button "Sign out"
    expect(page).to have_button('Sign in')
  end
end

