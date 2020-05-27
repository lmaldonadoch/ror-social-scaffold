class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @users.each do |user|
      user.gravatar_url = 'https://www.gravatar.com/avatar/' + Digest::MD5.hexdigest(user.email)
      user.save
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:comments).ordered_by_most_recent
    @user.gravatar_url = 'https://www.gravatar.com/avatar/' + Digest::MD5.hexdigest(@user.email)
  end

  def invitation
    if !(current_user.pending_friends.include?(User.find(params[:user_id])) ||
      current_user.friend_requests.include?(User.find(params[:user_id])))
      invite = Friendship.new(user_id: current_user.id, friend_id: params[:user_id], confirmed: 0)
      inverse_invite= Friendship.new(user_id: params[:user_id], friend_id:  current_user.id, confirmed: 0)	
	  invite.save
	  inverse_invite.save
      redirect_to users_path, notice: 'The friend invitation was sent!'
    elsif current_user.friend_requests.include?(User.find(params[:user_id]))
      redirect_to user_path(current_user.id), alert: 'There is a pending friend request from this user. Accept it here'
    else
      redirect_to users_path, alert: 'You have already invited this friend to connect. Please wait for their response.'
    end
  end

  def accept
    invitation = Friendship.find_by(friend_id: current_user.id, user_id: params[:friends_id].to_i)
    invitation.confirmed = 1
    invitation.save
    redirect_to user_path(current_user.id), notice: 'The friend invitation has been approved!'
  end

  def reject
    invitation = Friendship.find_by(friend_id: current_user.id, user_id: params[:friends_id].to_i)
    invitation.destroy
    redirect_to user_path(current_user.id), notice: 'The friend invitation has been rejected!'
  end

  private

  def user_params
    params.require(:user).permit(:name, :id)
  end
end
