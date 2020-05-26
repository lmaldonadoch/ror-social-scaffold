require 'rails_helper'


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
