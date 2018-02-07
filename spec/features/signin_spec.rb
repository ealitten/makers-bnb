feature 'User sign in' do
  scenario 'with correct username & pw' do
    create_test_user
    visit '/sessions/new'
    fill_in :name, with: 'Mr Test'
    fill_in :password, with: 'mypassword'
    click_button 'Sign in'
    expect(page).to have_content('Welcome Mr Test')
  end

  scenario 'with wrong pw' do
    create_test_user
    visit '/sessions/new'
    fill_in :name, with: 'Mr Test'
    fill_in :password, with: 'wrongpassword'
    click_button 'Sign in'
    expect(page).to have_content('Username or password is incorrect')
  end

  scenario 'with wrong username' do
    visit '/sessions/new'
    fill_in :name, with: 'Mr Test'
    fill_in :password, with: 'mypassword'
    click_button 'Sign in'
    expect(page).to have_content('Username or password is incorrect')
  end

end