class CollectionPolicy < ApplicationPolicy
  class Scope < Scope
    def initialize(user, scope, friend = nil)
      @user = user
      @scope = scope
      @friend = friend || user
    end
    # NOTE: Be explicit about which records you allow access to!

    def resolve
      scope.where(user_id: @friend.id)
    end
  end

  def index?
    user.id == record.user_id
  end

  def show?
    user.id == record.user_id || (user.friendships.find_by(friend_id: record.user_id) && (user.friendships.find_by(friend_id: record.user_id).status == 'accepted'))
  end

  def add_catch?
    user.id == record.user_id
  end

  def remove_catch?
    user.id == record.user_id
  end

  def general?
    user.id == record[0].user_id || (user.friendships.find_by(friend_id: record[0].user_id) && (user.friendships.find_by(friend_id: record[0].user_id).status == 'accepted'))
  end

  def create?
    user.id == record.user_id
  end

  def update?
    user.id == record.user_id
  end

  def destroy?
    user.id == record.user_id
  end
end
