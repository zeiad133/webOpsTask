class OfferSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :description
end
