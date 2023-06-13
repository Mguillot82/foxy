class FriendshipsController < ApplicationController
  # before_action :set_friendship, only: [:update, :destroy]
  def create
    friend = User.find_by(username: params[:username])

    if friend
      @friendship = current_user.friendships.build(friend: friend)
      authorize @friendship

      if @friendship.save
        redirect_to friend_path(friend), notice: 'Friendship request sent.'
      else
        redirect_to friend_path(friend), alert: "Failed to send friendship request."
      end
    else
      redirect_to new_friendship_path, alert: "User not found."
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:username)
  end
end
# def index
#   @friends = current_user.friends
# end
#   def new
#   end

#   def create
#     @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
#     if @friendship.save
#       flash[:notice] = "Added friend."
#     else
#       flash[:notice] = "Unable to add friend."
#     end
#   end

#   def show
#   end
# end
# def update
#   authorize @friendship

#   if @friendship.update(friendship_params)
#     redirect_to @friendship.friend, notice: 'Friendship added.'
#   else
#     redirect_to @friendship.friend, alert: "Couldn't update friendship."
#   end
# end

# def destroy
#   authorize @friendship

#   @friendship.destroy
#   redirect_to friends_path, notice: "Friend removed."
# end

# private

#   def set_friendship
#     @friendship = Friendship.find(params[:id])
#   end

#   def friendship_params
#     params.require(:friendship).permit(:status)
#   end
# end
