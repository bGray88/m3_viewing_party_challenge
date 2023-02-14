require 'rails_helper'

RSpec.describe "User login form" do
  before(:each) do
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

    fill_in :email, with: @username
    fill_in :password, with: @password

    within('#login') do
      click_on "Log In"
    end

    visit user_path(User.last)

    expect(page).to have_content("Log Out")

    click_link("Log Out")
  end
end
