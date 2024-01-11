class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes

  def self.comment_counter(post_id)
    Post.find(post_id).comments.count
  end
end
