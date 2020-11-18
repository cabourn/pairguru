class PairguruApi
  API_ENDPOINT = 'https://pairguru-api.herokuapp.com/api/v1/'.freeze

  def movie_details(title)
    Rails.cache.fetch([:movie_details, title], expires_in: 24.hours) do
      Faraday.get "#{API_ENDPOINT}/movies/#{title}"
    end
  end
end
