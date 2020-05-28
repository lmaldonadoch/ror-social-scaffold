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
      content_tag(:span, ("You are friend with #{user.name}"), class: 'user-friend')
    elsif current_user.pending_friends.include?(user)
      content_tag(:span, ("Your friend request is pending"), class: 'user-invite')
    elsif user.id != current_user.id
      content_tag(:span, (link_to 'Invite', invitation_path(:user_id => user.id), method: :post), class: 'profile-link', method: :post)
    end
  end

  def pending_friends(user)
	if user.id == current_user.id
		unless user.pending_friends.empty?
			content_tag(:h3, ("Pending friend requests:"))

			user.pending_friends.each do |f|  
				# content_tag(:div, 
			content_tag(:p, (link_to f.user.name, user_path(f.user.id)))
			# ,class: ["user-invite","show-requests"])
			end 
		end 	
	end
  end

  def friend_requests(user)
	if user.id == current_user.id
		unless user.friend_requests.empty?
			content_tag(:h3, ("Pending friend invitations:"))

			# user.friend_requests.each do |f|  
			# 	content_tag(:div, content_tag(:p, (link_to f.name, user_path(f.id))),class: ["user-invite","show-requests"])
			# 	content_tag(:span, (link_to 'Accept', accept_path(:friends_id => f.id), method: :put), class: 'profile-link')
			# 	content_tag(:span, (link_to 'Reject', reject_path(:friends_id => f.id), method: :delete), class: 'profile-link')
			# end 
		end 	
	end
  end

end
