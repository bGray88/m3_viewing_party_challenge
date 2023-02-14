require "rails_helper"

RSpec.describe "Movies Index Page" do
  before do
    @user1 = create(:user)
    20.times.with_index(1) do |num, i|
      Movie.create(title: "Movie #{i} Title", rating: rand(1..10),
                   description: "This is a description about Movie #{i}")
    end
  end

  it "shows all movies" do
    visit user_path(@user1)

    click_button "Find Top Rated Movies"

    expect(current_path).to eq(movies_path(@user1))

    expect(page).to have_content("Top Rated Movies")

    movie1 = Movie.first

    click_link(movie1.title)

    expect(current_path).to eq(movie_path(@user1, movie1))

    expect(page).to have_content(movie1.title)
    expect(page).to have_content(movie1.description)
    expect(page).to have_content(movie1.rating)
  end

  it 'denies access without login' do
    movie1 = Movie.first
    visit movie_path(@user1, movie1)

    expect(current_path).to eq(movie_path(@user1, movie1))

    click_button("Create Viewing Party")

    expect(current_path).to eq(movie_path(@user1, movie1))
    expect(page).to have_content("Login necessary")
  end
end
