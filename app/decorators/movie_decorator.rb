class MovieDecorator < Draper::Decorator
  delegate_all

  API_ENDPOINT = 'https://pairguru-api.herokuapp.com'.freeze

  def plot
    movie_data["plot"]
  end

  def cover
    if movie_data
      API_ENDPOINT + movie_data["poster"]
    else
      "http://lorempixel.com/100/150/" +
      %w[abstract nightlife transport].sample +
      "?a=" + SecureRandom.uuid
    end
  end

  def rating
    movie_data["rating"]
  end

  def fetch_movie
    pairguru_api = PairguruApi.new
    response = pairguru_api.movie_details(title.gsub(" ", "%20"))
    JSON.parse(response.body)
  end

  def movie_data
    fetch_movie.dig("data", "attributes")
  end
end
