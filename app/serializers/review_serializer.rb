class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :message, :stars, :client
end
