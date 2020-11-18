require "rails_helper"

describe 'PairguruApi' do
  let(:client) { PairguruApi.new }

  it "returns success status" do
    VCR.use_cassette('kill_bill', :re_record_interval => 7.days) do
      response = client.movie_details("Kill%20Bill")
      expect(response.status).to eq(200)
    end
  end

  it "returns movie details" do
    movie_title = "Kill Bill"
    VCR.use_cassette('kill_bill', :re_record_interval => 7.days) do
      response = client.movie_details(movie_title.gsub(" ", "%20"))
      json_body = JSON.parse(response.body)
      expect(json_body).to be_an_instance_of(Hash)
      expect(json_body).to include("data" => a_hash_including("attributes" => a_hash_including("title" => movie_title)))
    end
  end
end
