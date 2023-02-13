require "rails_helper"

RSpec.describe "Landing Page" do
  before :each do
    @user1 = create(:user)
    @user2 = create(:user)
    visit root_path
  end

  it "has a header" do
    expect(page).to have_content("Viewing Party Lite")
  end

  it "has links/buttons that link to correct pages" do
    click_button "Create New User"

    expect(current_path).to eq(register_path)

    visit root_path

    click_link "Home"
    expect(current_path).to eq(root_path)
  end

  it "has a link to 'Log In' page" do
    click_button "Log In"

    expect(current_path).to eq(login_path)

    visit login_path

    click_link "Home"
    expect(current_path).to eq(root_path)
  end

  it "lists out existing users" do
    expect(page).to have_content("Existing Users:")

    within(".existing-users") do
      expect(page).to have_content(@user1.email)
      expect(page).to have_content(@user2.email)
    end
  end
end
