class AddFriendRequestSenderToFriendship < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :friendship_requester, :integer
  end
end
