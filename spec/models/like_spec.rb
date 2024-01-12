require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Like model' do
    it 'should increase likes count on the post' do
      user1 = User.create(name: 'may', photo: 'mm',
                          bio: 'student', posts_counter: 0)
      post = Post.create(title: 'Fishbone', text: 'cats like fish', author: user1, like_counter: 5,
                         comment_counter: 2)
      like = Like.create(post:, user: user1)

      expect { like.update_likes_counter }.to change { post.reload.like_counter }.by(1)
    end
  end
end
