class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    user_posts = current_user.posts
    p '********************Time line posts******************'
    p current_user.id
    p current_user.name
    friend_posts = []

    current_user.friends.each do |friend|
      friend_posts << friend.posts
    end

    p friend_posts

    @timeline_posts = []

    @timeline_posts << user_posts
    @timeline_posts << friend_posts

    @timeline_posts.flatten!
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
