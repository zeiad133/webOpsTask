class PortfolioSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :time , :tag , :client , :image_url

  def time
    object.time.strftime("%b %d, %Y")
  end
end
