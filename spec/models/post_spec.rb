require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.new(name: 'user1') }

  subject { Post.new(title: 'Intro', text: 'Hi', comment_counter: 0, like_counter: 2, author: user) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'cannot be blank' do
    subject.title = nil
    expect(subject).to be_invalid
    expect(subject.errors[:title]).to include("can't be blank")
  end

  it 'is not valid with a title longer than 250 characters' do
    subject.title = 'may' * 251
    expect(subject.errors[:title]).to be_empty
  end

  it 'should be invalid for likes counters' do
    subject.like_counter = nil
    expect(subject).to be_invalid
  end

  it 'updates the likes counter after creating a like' do
    expect(subject.like_counter).to eq(2)
  end

  it 'updates the likes counter after creating a like' do
    expect(subject.comment_counter).to eq(0)
  end

  it 'should be invalid for comment counters' do
    subject.comment_counter = nil
    expect(subject).to be_invalid
  end

  it 'Text should be the same' do
    expect(subject.text).to eq('Hi')
  end
end
