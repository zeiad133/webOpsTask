class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description , :image_url , :tag
end
