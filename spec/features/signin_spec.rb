feature 'User sign in' do
  scenario 'with correct username & pw' do
    sign_up
    login
    expect(page).to have_content('Welcome Alex')
  end

  scenario 'with wrong pw' do
    sign_up
    login(password: 'wrongpassword')
    expect(page).to have_content('Username or password is incorrect')
  end

  scenario 'when user does not exist' do
    login
    expect(page).to have_content('Username or password is incorrect')
  end

  scenario 'with multiple users in database' do
    sign_up(name: 'User1', email: 'user1@example.com')
    sign_up(name: 'User2', email: 'user1@example.com')
    login(name: 'User1')
    expect(page).to have_content('Welcome User1')
  end

end