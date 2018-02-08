# As a user
# So that I can list a space
# I would like to sign up

feature 'First-time user can register' do
  scenario 'user enters details and sees welcome message' do
    sign_up
    expect(current_path).to eq '/users'
    expect(page).to have_button('Spaces')
    expect(page).to have_button('List Space')
    expect(page).to have_button('Requests')
    expect(page).to have_content('Welcome Alex')
  end

  scenario 'User enters registration details and is added to db' do
    expect{ sign_up }.to change { User.count }.by 1
  end

  scenario 'User cannot sign up when passwords do not match' do
    expect{ sign_up(password_confirmation: 'wrong') }.not_to change { User.count }
    expect(current_path).to eq '/users/new'
  end

end
