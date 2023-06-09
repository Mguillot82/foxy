class FriendsController < ApplicationController
  def index
    @friends = policy_scope(User, policy_scope_class: FriendPolicy::Scope)
  end

  def show
    @friend = User.find(params[:id])
    authorize @friend, policy_class: FriendPolicy
  end
end
