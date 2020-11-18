module Api
  module V2
    class MovieSerializer < ActiveModel::Serializer
      attributes :id, :title
      belongs_to :genre
    end
  end
end
