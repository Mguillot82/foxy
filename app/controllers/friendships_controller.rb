class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friendship, only: [:update, :destroy]

  def index
    @friends = current_user.friends
  end

  def create
    friend = User.find(params[:friend_id])
    @friendship = current_user.friendships.build(friend: friend)
  end

  def update
    authorize @friendship

    if @friendship.update(friendship_params)
      redirect_to @friendship.friend, notice: 'Friendship added.'
    else
      redirect_to @friendship.friend, alert: "Couldn't update friendship."
    end
  end

  def destroy
    authorize @friendship

    @friendship.destroy
    redirect_to friends_path, notice: "Friend removed."
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(:status)
  end
end
