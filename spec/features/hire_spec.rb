feature 'Hire' do
  scenario 'user books available space' do
    create_test_user
    Space.create(title: 'test', description: 'test', price: 10, user_id: 1)
    sign_up
    expect{ hire }.to change { Hire.count }.by 1
    expect(Hire.first.date.xmlschema).to eq('2109-01-02')
    expect(Hire.first.user_id).to eq(2)
    expect(Hire.first.space_id).to eq(1)
  end
end

  def hire
    visit '/spaces'
    fill_in :date, with: '02/01/2109'
    click_button 'Hire'
  end
