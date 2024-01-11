class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.like_counter(post_id)
    Post.find(post_id).likes.count
  end
end
