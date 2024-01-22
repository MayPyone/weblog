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
    @post1 = Post.create!(title: 'Intro2', text: 'Hi', comment_counter: 0, like_counter: 2, author: @user2)
  end

  describe 'returns user index page' do
    it "returns users' profile" do
      visit user_path(@user1)
      expect(page).to have_css("img[src*='#{@user1.photo}']")
      visit user_path(@user2)
      expect(page).to have_css("img[src*='#{@user2.photo}']")
    end

    it "returns specific user's name" do
      visit user_path(@user1)
      expect(page).to have_content('Khaing')
      visit user_path(@user2)
      expect(page).to have_content('May')
    end

    it 'return recent 3 posts' do
      visit user_path(@user1)
      expect(@user1.recent_posts.count).to have_content(3)
      visit user_path(@user2)
      expect(@user2.posts.count).to have_content(1)
    end

    it 'return number of posts' do
      visit user_path(@user1)
      expect(@user1.posts.count).to have_content(4)
      visit user_path(@user2)
      expect(@user2.posts.count).to have_content(1)
    end

    it "return user's bio" do
      visit user_path(@user1)
      expect(@user1.bio).to have_content('officer')
      visit user_path(@user2)
      expect(@user2.bio).to have_content('student')
    end

    it 'return a button that let see all posts' do
      visit user_path(@user1)
      expect(page).to have_selector('button', text: 'See all posts')
    end
  end
end
