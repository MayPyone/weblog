class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments

  def self.posts_counter(user_id)
    where(author_id: user_id).count
  end

  def self.recent_posts(user_id)
    where(author_id: user_id).order(created_at: :desc).limit(5)
  end
end
