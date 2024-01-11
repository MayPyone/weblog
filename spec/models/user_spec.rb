require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'may', bio: 'student', posts_counter: 1) }
  before { subject.save }

  it 'name should be valid' do
    expect(subject).to be_valid
  end

  it "name shouldn't be valid" do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'name should be valid' do
    subject.name = 'Bijay'
    expect(subject).to be_valid
  end

  it "post counter shouldn't be valid" do
    subject.posts_counter = nil
    expect(subject).not_to be_valid
  end

  it 'post counter should be valid' do
    subject.posts_counter = 5
    expect(subject).to be_valid
  end

  it 'Recent post should be 3' do
    post1 = Post.create(title: 'Intro1', text: 'Hi', comment_counter: 0, like_counter: 2, author: subject)
    post2 = Post.create(title: 'Intro2', text: 'Hi', comment_counter: 0, like_counter: 2, author: subject)
    post3 = Post.create(title: 'Intro3', text: 'Hi', comment_counter: 0, like_counter: 2, author: subject)

    expect(subject.recent_posts.count).to eq(3)
  end
end
