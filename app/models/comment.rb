class Comment < ApplicationRecord
    belongs_to :post
    belongs_to :user , optional:true
    validates :description, presence: true 
    validates :description, length: { in: 1..255, allow_nil: false }

    def self.add_comment_to_post(post , description)
        @post = post 

        @comment = Comment.new(description: description)
        @comment.post = @post
        @comment.user = @post.user
        @comment.save!
      
      end


end
