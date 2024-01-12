require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Comment model' do
    it 'should increase comment count on the post' do
      user1 = User.create(name: 'may', photo: 'mm',
                          bio: 'student', posts_counter: 0)
      post = Post.create(title: 'The sea', text: 'Fish swim', author: user1, like_counter: 5,
                         comment_counter: 2)
      comment = Comment.create(post:, user: user1)

      expect { comment.update_comments_counter }.to change { post.reload.comment_counter }.by(1)
    end
  end
end
