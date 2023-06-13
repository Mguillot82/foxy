class FriendsController < ApplicationController
  before_action :set_friend, only: %i[show reject add]
  before_action :set_friendship, only: [:update, :destroy]

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
  
  def new
    @friendship = Friendship.new(user: current_user)

    authorize @friendship, policy_class: FriendPolicy
  end

  def create
    friend = User.find(params[:friend_id])
    @friendship = Friendship.new(user: current_user, friend: friend)
    authorize @friends, policy_class: FriendPolicy
    if @friendship.save
      redirect_to friend_path(friend), notice: 'Friendship added.'
    else
      redirect_to friend_path(friend), alert: "Couldn't create friendship."
    end
  end

  def update
    authorize @friendship, policy_class: FriendPolicy

    if @friendship.update(friendship_params)
      redirect_to @friendship.friend, notice: 'Friendship updated.'
    else
      redirect_to @friendship.friend, alert: "Couldn't update the friendship."
    end
  end

  def destroy
    authorize @friendship, policy_class: FriendPolicy

    @friendship.destroy
    redirect_to friends_path, notice: "Friend removed."
  end

  def invite
    friend = User.find_by(username: params[:username])

    if friend
      @friendship = current_user.friendships.build(friend: friend)
      authorize @friendship, policy_class: FriendPolicy

      if @friendship.save
        redirect_to friends_path, notice: 'Friendship request sent.'
      else
        redirect_to friends_path, alert: "Failed to send friendship request."
      end
    else
      redirect_to new_friend_path, alert: "User not found."
    end
  end

  private
  
  def set_friend
    @friend = User.find(params[:id])
  end
  
  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(:status)
  end
end
