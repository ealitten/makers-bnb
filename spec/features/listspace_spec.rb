# As a user
# So that someone can hire my space
# I would like to list a space

feature 'list space' do
  scenario 'find page to list space' do
    sign_up
    visit '/spaces/new'
    expect(page).to have_content('List a space:')
  end

  scenario 'a space listed is in the Space database' do
    sign_up
    list_space
    expect{ list_space }.to change { Space.count }.by 1
    expect(Space.all.map(&:title)).to include("Highfield House")
  end

end
