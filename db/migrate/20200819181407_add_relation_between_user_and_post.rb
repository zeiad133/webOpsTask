class AddRelationBetweenUserAndPost < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :user, index: true
    add_reference :comments, :user, index: true
  end
end
