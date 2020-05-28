module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def user_index_friendship_status(user)
    if user.friend?(current_user)
      content_tag(:span, "You are friend with #{user.name}", class: 'user-friend')
    elsif current_user.pending_friends.include?(user)
      content_tag(:span, 'Your friend request is pending', class: 'user-invite')
    elsif user.id != current_user.id
      content_tag(:span, (link_to 'Invite', invitation_path(user_id: user.id),
                                  method: :post), class: 'profile-link', method: :post)
    end
  end

  def pending_friends_request(user)
    return unless user.id == current_user.id || !user.pending_friends.empty?

    users = []
    return if user.pending_friends.empty?

    user.pending_friends.each do |user_request|
      users << user_request
    end
    render 'user_friend_requests', users: users
  end

  def friend_requests(user)
    return unless user.id == current_user.id

    users = []
    return if user.friend_requests.empty?

    user.friend_requests.each do |user_friend|
      users << user_friend
    end
    render 'user_pending_invites', users: users
  end

  def post_rendering(user)
    if user.posts.empty?
      content_tag(:h3, 'You have no posts yet!')
    else
      posts = []
      user.posts.each do |post|
        posts << post
      end
      render 'posts/user_show_post', posts: posts
    end
  end

  def timeline_post(posts)
    render 'posts/user_show_post', posts: posts
  end
end
