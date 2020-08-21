class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body , :tags , :comments
end
