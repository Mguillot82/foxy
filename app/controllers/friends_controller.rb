class FriendsController < ApplicationController
  def index
    @friends = policy_scope(User, policy_scope_class: FriendPolicy::Scope)
  end

  def show
    @friend = User.find(params[:id])
    authorize @friend, policy_class: FriendPolicy
  end

  def friends_requests
    @friends_requests = current_user.friends.joins(:friendships).where(friendships: { status: 'pending' })
    authorize @friends_requests, policy_class: FriendPolicy
  end

  def reject
    friend = User.find(params[:id])
    authorize friend, policy_class: FriendPolicy
    friend.friendships.find_by(friend_id: current_user.id).destroy
    redirect_to friends_requests_path
  end

  def add
    friend = User.find(params[:id])
    authorize friend, policy_class: FriendPolicy
    friend.friendships.find_by(friend_id: current_user.id).update(status: 'accepted')
    redirect_to friends_requests_path
  end
end
