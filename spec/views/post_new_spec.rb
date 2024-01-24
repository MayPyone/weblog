require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  before do
    @user1 = User.create!(id: 5, name: 'Bijay',
                          photo: 'https://c0.klipartz.com/pngpicture/695/991/gratis-png-profesor.png', bio: 'officer')
    @user2 = User.create!(id: 6, name: 'May',
                          photo: 'https://c0.klipartz.com/pngpicture/695/991/gratis-png-profesor.png', bio: 'student')
    @post1 = Post.create!(title: 'Intro', text: 'Hi', comment_counter: 0, like_counter: 2, author: @user2)
    @comment1 = Comment.create(post: @post1, user: @user2, text: 'My comment')
    @like1 = Like.create(post: @post1, user: @user2)
  end

  describe 'Create a new post' do
    it 'return comment form content' do
      visit new_user_post_comment_path(@user2, @post1)
      fill_in 'comment_text', with: 'This is a comment'
      click_button('Create Comment')
      expect(page).to have_content(@user2.name)
    end
  end
end
