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
  end
end