require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  before do
    @user1 = User.create!(id: 5, name: 'Khaing',
                          photo: 'https://c0.klipartz.com/pngpicture/695/991/gratis-png-profesor.png', bio: 'officer')
    @user2 = User.create!(id: 6, name: 'May',
                          photo: 'https://c0.klipartz.com/pngpicture/695/991/gratis-png-profesor.png', bio: 'student')
    Post.create!(title: 'Intro', text: 'Hi', comment_counter: 0, like_counter: 2, author: @user1)
    Post.create!(title: 'Intro1', text: 'Hi', comment_counter: 0, like_counter: 2, author: @user1)
    Post.create!(title: 'Intro', text: 'Hi', comment_counter: 0, like_counter: 2, author: @user1)
    Post.create!(title: 'Intro', text: 'Hi', comment_counter: 0, like_counter: 2, author: @user1)
    @post1 = Post.create!(title: 'Intro', text: 'Hi', comment_counter: 0, like_counter: 2, author: @user2)

    @comment1 = Comment.create(post: @post1, user: @user2, text: 'My comment')
    @comment2 = Comment.create(post: @post1, user: @user1, text: 'Comment2')

    @like1 = Like.create(post: @post1, user: @user2)
  end

  describe 'returns post show page' do
    it "returns author's name" do
      visit user_posts_path(@user2)
      expect(@user2.name).to have_content('May')
    end

    it 'returns username of each commentor.' do
      comments = @post1.comments
      expect(comments[0].user.name).to eq('May')
      expect(comments[1].user.name).to eq('Khaing')
    end

    it "return post's title" do
      visit user_posts_path(@user2)
      expect(@user2.posts[0].title).to have_content('Intro')
    end

    it "return post's body" do
      visit user_posts_path(@user2)
      expect(@user2.posts[0].text).to have_content('Hi')
    end

    it 'return comment' do
      visit user_post_path(@user2, @post1)
      expect(@user2.posts[0].recent_comments.map(&:text)).to include('My comment')
    end
    it 'return number of comments' do
      visit user_post_path(@user2, @post1)
      expect(@user2.posts[0].comments.count).to have_content(2)
    end

    it 'return number of likes' do
      visit user_post_path(@user2, @post1)
      expect(@user2.posts[0].likes.count).to have_content(1)
    end
  end
end
