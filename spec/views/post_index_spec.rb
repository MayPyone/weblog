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
    Post.create!(title: 'Intro', text: 'Hi', comment_counter: 0, like_counter: 2, author: @user1)

    @post1 = Post.create!(title: 'Intro2', text: 'Hi', comment_counter: 0, like_counter: 2, author: @user2)
    @comment1 = Comment.create(post: @post1, user: @user2, text: 'My comment')
    @like1 = Like.create(post: @post1, user: @user2)
  end

  describe 'returns user index page' do
    it "returns user's profile" do
      visit user_posts_path(@user2)
      expect(page).to have_css("img[src*='#{@user2.photo}']")
    end

    it 'returns user name' do
      visit user_posts_path(@user2)
      expect(page).to have_content('May')
    end

    it 'return number of posts' do
      visit user_posts_path(@user2)

      expect(@user2.posts.count).to have_content(1)
    end

    it 'return pagination button' do
      visit user_path(@user1)
      click_link 'See all posts'
      sleep 10
      expect(page).to have_css('.paginate')
    end

    it "return post's title" do
      visit user_posts_path(@user2)
      expect(@user2.posts[0].title).to have_content('Intro')
    end

    it "return post's body" do
      visit user_posts_path(@user2)
      expect(@user2.posts[0].text).to have_content('Hi')
    end

    it 'return first comment' do
      visit user_post_path(@user2, @post1)
      expect(@user2.posts[0].recent_comments.map(&:text)).to include('My comment')
    end
    it 'return number of comments' do
      visit user_post_path(@user2, @post1)
      expect(@user2.posts[0].comments.count).to have_content(1)
    end

    it 'return number of likes' do
      visit user_post_path(@user2, @post1)
      expect(@user2.posts[0].likes.count).to have_content(1)
    end
    it 'redirect to sepcific post when the user click the post' do
      visit user_path(@user2)
      click_link 'Intro2'
      sleep 15
      expect(current_path).to eq(user_post_path(@user2, @post1))
    end
  end
end
