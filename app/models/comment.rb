class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes
  after_save :update_comments_counter

  def update_comments_counter
    post.increment!(:comment_counter)
  end
end
