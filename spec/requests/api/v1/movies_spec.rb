require "rails_helper"

RSpec.describe 'Api::V1::Movies' do
  describe 'GET /api/v1/movies' do
    before do
      create_list(:movie, 5)
      get '/api/v1/movies'
    end

    it 'returns a success status' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a list of movies' do
      movies = response.parsed_body["data"]

      expect(movies.length).to eq(5)
    end
  end

  describe 'GET /api/v1/movies/:id' do
    let(:movie) { create(:movie) }

    it 'returns a success status' do
      get "/api/v1/movies/#{movie.id}"

      expect(response).to have_http_status(:success)
    end

    it 'returns the correct attributes' do
      get "/api/v1/movies/#{movie.id}"

      movie = response.parsed_body["data"]

      expect(movie).to include("id", "type")
      expect(movie["attributes"]).to include("title")
    end
  end
end
