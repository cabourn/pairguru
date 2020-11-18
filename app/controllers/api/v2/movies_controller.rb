module Api
  module V2
    class MoviesController < ApiController
      def show
        @movie = Movie.find(params[:id])
        render json: @movie, include: ['genre'], status: 200
      end

      def index
        @movies = Movie.all
        render json: @movies, status: 200
      end
    end
  end
end
