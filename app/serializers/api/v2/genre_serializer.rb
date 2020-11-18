module Api
  module V2
    class GenreSerializer < ActiveModel::Serializer
      attributes :id, :name, :movie_count
      has_many :movies

      def movie_count
        object.movies.count
      end
    end
  end
end
