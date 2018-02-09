feature 'User sign in' do
  scenario 'with correct username & pw' do
    sign_up
    signin
    expect(page).to have_content('Welcome Alex')
  end

  scenario 'with wrong pw' do
    sign_up
    signin(password: 'wrongpassword')
    expect(page).to have_content('Username or password is incorrect')
  end

  scenario 'when user does not exist' do
    signin
    expect(page).to have_content('Username or password is incorrect')
  end

  scenario 'with multiple users in database' do
    sign_up(name: 'User1', email: 'user1@example.com')
    click_button("Sign out")
    sign_up(name: 'User2', email: 'user2@example.com')
    click_button("Sign out")
    signin(name: 'User2')
    expect(page).to have_content('Welcome User2')
  end

end
