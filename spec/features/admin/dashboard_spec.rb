require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user, :admin)
  end

  it 'lists existing user emails as linked if logged in as admin' do
    visit login_path

    fill_in :email, with: @user2.email
    fill_in :password, with: @user2.password

    within('#login') do
      click_on "Log In"
    end

    expect(page).to have_content("All Users:")
    expect(page).to have_link(@user1.email)

    click_on "Log Out"
  end

  it 'listed email links as admin route to admin_user_dashboard' do
    visit login_path

    fill_in :email, with: @user2.email
    fill_in :password, with: @user2.password

    within('#login') do
      click_on "Log In"
    end

    click_on(@user1.email)

    expect(current_path).to eq(admin_user_dashboard_path(@user1))

    click_on "Log Out"
  end

  it 'denies access without authorization' do
    visit login_path

    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password

    within('#login') do
      click_on "Log In"
    end

    visit admin_user_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Not authorized to access requested")

    visit admin_user_dashboard_path(@user1)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Not authorized to access requested")
  end
end
