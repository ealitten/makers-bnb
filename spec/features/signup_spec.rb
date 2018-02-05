# As a user
# So that I can list a space
# I would like to sign up

feature 'sign-up' do
  scenario 'user enters details and sees welcome message' do
    sign_up
    expect(page).to have_content('Welcome Alex')
  end

  scenario 'user is stored in database' do
    expect{ sign_up }.to change { User.count }.by 1
  end

end