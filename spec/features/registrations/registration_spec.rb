require 'rails_helper'

RSpec.describe "User registration form" do
  it "creates new user" do
    visit register_path

    expect(current_path).to eq(register_path)

    fullname  = "Harvey Weinstein"
    username  = "funbucket13@gmail.com"
    password  = "test"

    fill_in :user_name, with: fullname
    fill_in :user_email, with: username
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password

    click_on "Create New User"

    expect(User.last).to_not have_attribute(:password)
    expect(current_path).to eq(login_path)
    expect(page).to have_content("Please Log In, #{fullname}")
  end

  it "won't create user with mismatching passwords" do
    visit register_path

    expect(current_path).to eq(register_path)

    fullname  = "Cheech Marin"
    username  = "funbonghit13@gmail.com"
    password  = "test"

    fill_in :user_name, with: fullname
    fill_in :user_email, with: username
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: "tets"

    click_on "Create New User"

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password confirmation doesn't match")
  end

  it "won't create user with missing attributes" do
    visit register_path

    expect(current_path).to eq(register_path)

    fullname  = "Cheech Marin"
    username  = "funbonghit13@gmail.com"
    password  = "test"

    fill_in :user_name, with: fullname
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: "test"

    click_on "Create New User"

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email can't be blank")
  end
end
