class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def invitation
    p params
    invitation = Friendship.create(user_id: current_user.id, friend_id: params[:user][:id], status: 0)
  end

  private

  def user_params
    params.require(:user).permit(:name, :id)
  end
end
