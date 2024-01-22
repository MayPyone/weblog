require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      user = User.create(name: 'May Pyone  ', id: '1')
      get user_posts_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      user = User.create(name: 'May Pyone  ', id: '1')
      post = Post.create(author: user, title: 'Hello', text: 'This is my first post')
      get user_post_path(user, post)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Elements for posts' do
    it 'render the template of post index' do
      user = User.create(name: 'May Pyone  ', id: '1')
      get user_posts_path(user)
      expect(response.body).to render_template('index')
    end

    it 'render the show template for post' do
      user = User.create(name: 'May Pyone  ', id: '1')
      post = Post.create(author: user, title: 'Hello', text: 'This is my first post')
      get user_post_path(user, post)
      expect(response.body).to render_template('show')
    end
  end
end
