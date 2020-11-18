module Api
  module V1
    class MovieSerializer < ActiveModel::Serializer
      attributes :id, :title
    end
  end
end
