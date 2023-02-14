require 'rails_helper'

RSpec.describe 'User Dashboard' do
  before(:each) do
    @user1 = create(:user)
  end

  it 'lists existing user emails if logged in' do
    visit login_path

    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password

    within('#login') do
      click_on "Log In"
    end

    visit root_path

    expect(page).to have_content("Existing Users:")
    expect(page).to have_content(@user1.email)

    click_on "Log Out"
  end
end
