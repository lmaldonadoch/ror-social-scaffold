class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.includes(:posts)
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
      invite = Friendship.new(user_id: current_user.id, friend_id: params[:user_id], confirmed: 0, friendship_requester: current_user.id)
      inverse_invite= Friendship.new(user_id: params[:user_id], friend_id:  current_user.id, confirmed: 0, friendship_requester: current_user.id)	
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
    invitations = []
    invitations << Friendship.where(friendship_requester: params[:friends_id].to_i, friend_id: current_user.id).or(Friendship.where(friendship_requester: params[:friends_id].to_i, user_id: current_user.id))
    invitations.flatten!
    invitations.each do |invitation|
      invitation.confirmed = 1
      invitation.save
    end
    redirect_to user_path(current_user.id), notice: 'The friend invitation has been approved!'
  end

  def reject
    # invitation = Friendship.find_by(friend_id: current_user.id, user_id: params[:friends_id].to_i)
    # invitation.destroy
    # redirect_to user_path(current_user.id), notice: 'The friend invitation has been rejected!'
  
	
	rejections = []
    rejections << Friendship.where(friendship_requester: params[:friends_id].to_i, friend_id: current_user.id).or(Friendship.where(friendship_requester: params[:friends_id].to_i, user_id: current_user.id))
    rejections.flatten!
    rejections.each do |rejection|
      rejection.destroy
     end
    redirect_to user_path(current_user.id), notice: 'The friend invitation has been rejected!'
  end

  private

  def user_params
    params.require(:user).permit(:name, :id)
  end
end
