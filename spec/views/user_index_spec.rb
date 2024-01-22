require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  before do
    @user1 = User.create!(id: 5, name: 'San',
                          photo: 'https://c0.klipartz.com/pngpicture/695/991/gratis-png-profesor.png')
    @user2 = User.create!(id: 6, name: 'May',
                          photo: 'https://c0.klipartz.com/pngpicture/695/991/gratis-png-profesor.png')
    Post.create!(title: 'Intro', text: 'Hi', comment_counter: 0, like_counter: 2, author: @user1)
    Post.create!(title: 'Intro', text: 'Hi', comment_counter: 0, like_counter: 2, author: @user1)
    Post.create!(title: 'Intro', text: 'Hi', comment_counter: 0, like_counter: 2, author: @user2)
  end

  describe 'returns user index page' do
    it "returns users' names" do
      visit users_path
      expect(page).to have_content(@user1.name)
      expect(page).to have_content(@user2.name)
    end

    it "returns users' image link" do
      visit users_path
      expect(page).to have_css("img[src*='#{@user1.photo}']")
      expect(page).to have_css("img[src*='#{@user2.photo}']")
    end

    it 'return number of posts' do
      visit users_path
      expect(@user1.posts.count).to have_content(2)
      expect(@user2.posts.count).to have_content(1)
    end
    it 'redirects to user show page' do
      visit users_path
      click_link @user1.name
      sleep 15
      expect(current_path).to eq(user_path(@user1))
    end
  end
end
