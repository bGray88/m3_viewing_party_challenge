require 'rails_helper'

RSpec.describe "User login" do
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)

    visit register_path

    @fullname  = "Harvey Weinstein"
    @username  = "funbucket13@gmail.com"
    @password  = "test"

    fill_in :user_name, with: @fullname
    fill_in :user_email, with: @username
    fill_in :user_password, with: @password
    fill_in :user_password_confirmation, with: @password
    
    click_on "Create New User"
  end

  it "has existing user login" do
    visit login_path

    expect(current_path).to eq(login_path)

    fill_in :email, with: @username
    fill_in :password, with: @password

    within('#login') do
      click_on "Log In"
    end

    expect(page).to have_content("#{@fullname}'s Dashboard")
  end

  it "won't create user with mismatching passwords" do
    visit login_path

    expect(current_path).to eq(login_path)

    password = "tets"

    fill_in :email, with: @username
    fill_in :password, with: password

    within('#login') do
      click_on "Log In"
    end

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Sorry, your credentials are bad")
  end

  it 'lists existing user emails if logged in' do
    visit login_path

    fill_in :email, with: @username
    fill_in :password, with: @password

    within('#login') do
      click_on "Log In"
    end

    visit root_path

    expect(page).to have_content("Existing Users:")

    expect(page).to have_content(@user1.email)
    expect(page).to have_content(@user2.email)
  end
end
