require 'rails_helper'
RSpec.feature 'User', type: :feature do
  scenario 'Creates a new User' do
    visit 'http://localhost:3000/users/sign_up'

    within find('#new_user') do
      fill_in 'user_name', with: 'RSpec'
      fill_in 'user_email', with: 'rspec@something.com'
      fill_in 'user_password', with: '123456'
      fill_in 'user_password_confirmation', with: '123456'
      click_button 'commit'
    end
  rescue StandardError => e
    puts e.message.to_s
  end
end

RSpec.describe User, type: :model do
  describe '#name' do
    before :each do
      User.create(name: 'test', email: 'test@test.com')
    end
    it 'doesnt take user without the name' do
      user = User.new
      user.name = nil
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")

      user.name = 'test'
      user.valid?
      expect(user.errors[:name]).to_not include("can't be blank")
    end
  end

  describe '#email' do
    before :each do
      User.create(name: 'test', email: 'test@test.com')
    end
    it 'doesnt take user without the email' do
      user = User.new
      user.email = nil
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")

      user.email = 'test'
      user.valid?
      expect(user.errors[:email]).to_not include("can't be blank")
    end
  end
end

RSpec.describe Friendship, type: :model do
  describe '#friendship' do
    before :each do
      Friendship.create(user_id: 1, friend_id: 2)
    end
    it 'doesnt take friendship without user_id' do
      friend = Friendship.new
      friend.user_id = nil
      friend.valid?
      expect(friend.errors[:user_id]).to include("can't be blank")

      friend.user_id = 1
      friend.valid?
      expect(friend.errors[:name]).to_not include("can't be blank")
    end
  end

  describe '#friend_id' do
    before :each do
      Friendship.create(user_id: 1, friend_id: 2)
    end
    it 'doesnt take friendship without friend_id' do
      friend = Friendship.new
      friend.friend_id = nil
      friend.valid?
      expect(friend.errors[:friend_id]).to include("can't be blank")

      friend.friend_id = 2
      friend.valid?
      expect(friend.errors[:friend_id]).to_not include("can't be blank")
    end
  end
end
