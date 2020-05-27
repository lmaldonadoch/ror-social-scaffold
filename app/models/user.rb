class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 50 }

  def friends
    friends_array = friendships.map do |friendship|
      friendship.friend if friendship.confirmed == 1
    end
    friends_array.compact
  end

  def pending_friends
    friends_array = friendships.map do |friendship|
	  friendship.friend unless friendship.confirmed == 1 &&
	    friendship.friendship_requester == self.id 
    end
    friends_array.compact
  end

  def friend_requests
    friend_requests = inverse_friendships.map do |friendship|
      friendship.user unless friendship.confirmed == 1
    end
    friend_requests.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |friends| friends.user == user }
    friendship.confirmed = 1
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
