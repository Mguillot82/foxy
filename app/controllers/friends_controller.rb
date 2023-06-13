class FriendsController < ApplicationController
  before_action :set_friend, only: %i[show reject add]

  def index
    @friends = policy_scope(User, policy_scope_class: FriendPolicy::Scope)
  end

  def show
    authorize @friend, policy_class: FriendPolicy
  end

  def friends_requests
    @friends_requests = current_user.friends.joins(:friendships).where(friendships: { status: 'pending' }).distinct
    authorize @friends_requests, policy_class: FriendPolicy
  end

  def reject
    authorize @friend, policy_class: FriendPolicy
    Friendship.find_by(user_id: current_user.id, friend_id: @friend.id).update(status: "rejected")
    redirect_to friends_requests_friends_path
  end

  def add
    authorize @friend, policy_class: FriendPolicy
    Friendship.find_by(user_id: current_user.id, friend_id: @friend.id).update(status: 'accepted')
    redirect_to friends_requests_friends_path
  end

  private

  def set_friend
    @friend = User.find(params[:id])
  end
end
