class AddCommentsToPost < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :post, index: true

  end
end
