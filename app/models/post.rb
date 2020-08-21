class Post < ApplicationRecord
    has_many :comments, dependent: :delete_all
    has_many :tags, dependent: :delete_all
    belongs_to :user
    attr_accessor :comment_description, :tag_description
    validates :body, :title , presence: true 
    validates :body, :title, length: { in: 1..255, allow_nil: false }
    after_create :delete_after_1_day
    def delete_after_1_day
        PostDeletionWorker.perform_in(1.day , self.id)
    end

end
