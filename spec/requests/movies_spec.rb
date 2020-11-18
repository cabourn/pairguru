require "rails_helper"

describe "Movies requests", type: :request do
  describe "movies list" do
    before(:each) do
      create_list(:movie, 5)
      stub_request(:get, /pairguru-api.herokuapp.com/).to_return(body: mock_data.to_json, status: 200)
    end

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
    before(:each) do
      stub_request(:get, /pairguru-api.herokuapp.com/).to_return(body: mock_data.to_json, status: 200)
    end
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

private
def mock_data
  { "data" =>
    { "id" => "3",
      "type" => "movie",
      "attributes" => {
        "title" => "Kill Jill",
        "plot" => "The Bride wakens from a four-year coma. The child she carried in her womb is gone. Now she must wreak vengeance on the team of assassins who betrayed her - a team she was once part of.",
        "rating" => 8.1,
        "poster" => "/kill_bill.jpg"
      }
    }
  }
end
