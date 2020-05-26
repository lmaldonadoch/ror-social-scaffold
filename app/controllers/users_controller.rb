class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:comments).ordered_by_most_recent
  end

  def invitation
    p params
	invite = Friendship.new(user_id: current_user.id, 
		friend_id: params[:user_id], confirmed: 0)
    invite.save
    redirect_to users_path, notice: 'The friend invitation was sent!'
  end

  def accept
    accept_invite = current_user.friend_requests.select { |invite| invite.id == params[:friends_id].to_i}
    invitation = Friendship.find_by(friend_id: current_user.id, user_id: params[:friends_id].to_i)
    invitation.confirmed = 1
    invitation.save
    redirect_to user_path(current_user.id)
  end

  def reject
    reject_invite = current_user.friend_requests.select { |invite| invite.id == params[:friends_id].to_i}
    invitation = Friendship.find_by(friend_id: current_user.id, user_id: params[:friends_id].to_i)
    invitation.destroy
    redirect_to user_path(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :id)
  end
end


