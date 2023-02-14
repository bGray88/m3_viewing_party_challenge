require 'rails_helper'

RSpec.describe "Admin login form" do
  before(:each) do
    @admin = create(:user, :admin)
    @user = create(:user)
    visit login_path
  end

  it "log in as an admin and get to my dashboard" do
    fill_in :email, with: @admin.email
    fill_in :password, with: @admin.password

    expect(current_path).to eq(login_path)

    within('#login') do
      click_on "Log In"
    end

    expect(page).to have_content("Welcome, #{@admin.name}!")
    expect(current_path).to eq(admin_user_path)
  end

  describe "log in as default user" do
    it 'does not allow default user to see admin dashboard index' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit admin_user_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
