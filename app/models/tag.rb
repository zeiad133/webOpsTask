class Tag < ApplicationRecord
  belongs_to :post 
  validates :description, presence: true 
  validates :description, length: { in: 1..255, allow_nil: false }
    def self.add_tag_to_post(post , description)
      @post = post
      @tag = Tag.new(description: description)
      @tag.post = @post
      @tag.save!
    
    end
end
