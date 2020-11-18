require "rails_helper"

RSpec.describe 'Api::V2::Movies' do
  describe 'GET /api/v2/movies' do
    before do
      create_list(:movie, 5)
      get '/api/v2/movies'
    end

    it 'returns a success status' do
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("application/json")
    end

    it 'returns a list of movies' do
      movies = response.parsed_body["data"]

      expect(movies.length).to eq(5)
    end
  end

  describe 'GET /api/v2/movies/:id' do
    let(:movie) { create(:movie) }

    it 'returns a success status' do
      get "/api/v2/movies/#{movie.id}"

      expect(response).to have_http_status(:success)
    end

    it 'returns the correct attributes' do
      get "/api/v2/movies/#{movie.id}"

      movie_json = response.parsed_body["data"]

      expect(movie_json).to include("id", "type")
      expect(movie_json["attributes"]).to include("title")
    end

    it 'returns information regarding genre' do
      get "/api/v2/movies/#{movie.id}"

      expect(response.parsed_body).to include("data", "included")

      expected = {
        "included" => a_collection_including(
          a_hash_including(
            "attributes" => a_hash_including(
              "name" => movie.genre.name,
              "movie-count" => movie.genre.movies.count
            )
          )
        )
      }

      expect(response.parsed_body).to include(expected)
    end
  end
end
