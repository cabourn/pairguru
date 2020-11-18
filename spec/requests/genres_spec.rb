require "rails_helper"

describe "Genres requests", type: :request do
  let!(:genres) { create_list(:genre, 5, :with_movies) }

  describe "genre list" do
    it "displays only related movies" do
      stub_request(:get, /pairguru-api.herokuapp.com/).to_return(body: mock_data.to_json, status: 200)
      visit "/genres/" + genres.sample.id.to_s + "/movies"
      expect(page).to have_selector("table tr", count: 5)
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
