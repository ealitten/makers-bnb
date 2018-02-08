feature "sign out" do
  scenario "signs out when user clicks button" do
    sign_up
    login
    visit '/spaces'
    click_button "Sign out"
    expect(page).to have_button('Sign in')
  end
end

