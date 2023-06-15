class FriendsController < ApplicationController
  before_action :set_friend, only: %i[show reject add]
  before_action :set_friendship, only: [:update, :destroy]

  def index
    @friends_requests = User.joins(:friendships).where(friendships: { status: 'pending', friend: current_user }).distinct
    @friends = policy_scope(User, policy_scope_class: FriendPolicy::Scope)
  end

  def show
    authorize @friend, policy_class: FriendPolicy
  end

  def friends_requests
    @friends_requests = User.joins(:friendships).where(friendships: { status: 'pending', friend: current_user }).distinct
    authorize @friends_requests, policy_class: FriendPolicy
  end

  def reject
    authorize @friend, policy_class: FriendPolicy
    Friendship.find_by(user_id: @friend.id, friend_id: current_user.id).update(status: "rejected")
    Friendship.create(user_id: current_user.id, friend_id: @friend.id, status: "rejected")
    redirect_to friends_path
  end

  def add
    authorize @friend, policy_class: FriendPolicy
    Friendship.find_by(user_id: @friend.id, friend_id: current_user.id).update(status: 'accepted')
    Friendship.create(user_id: current_user.id, friend_id: @friend.id, status: 'accepted')
    redirect_to friends_path
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
      Friendship.create(user: friend, friend: current_user)
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

    authorize @friend, policy_class: FriendPolicy
    if friend
      @friendship = current_user.friendships.build(friend: friend)


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
