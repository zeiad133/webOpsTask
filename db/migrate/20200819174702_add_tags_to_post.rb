class AddTagsToPost < ActiveRecord::Migration[5.2]
  def change
    add_reference :tags, :post, index: true

  end
end
