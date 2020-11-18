require "rails_helper"

describe "Movies requests", type: :request do
  describe "movies list" do
    before { create_list(:movie, 5) }

    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end

    it "displays the rating for each movie" do
      visit "/movies"
      expect(page).to have_selector('.rating', count: 5)
    end
  end

  describe "movie show" do
    let(:movie) { create(:movie) }

    it "displays the movie rating" do
      visit "/movies/#{movie.id}"
      expect(page).to have_selector('.rating')
    end

    it "displays the movie title" do
      visit "/movies/#{movie.id}"
      expect(page).to have_content(movie.title)
    end
  end
end
