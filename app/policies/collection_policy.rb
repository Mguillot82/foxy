class CollectionPolicy < ApplicationPolicy
  class Scope < Scope
    def initialize(user, scope, friend)
      @user = user
      @scope = scope
      @friend = friend
    end
    # NOTE: Be explicit about which records you allow access to!

    def resolve
      if user.id == @friend.id
        scope.where(user_id: user.id)
      else
        scope.where(user_id: @friend.id)
      end
    end
  end

  def index?
    user.id == record.user_id
  end

  def show?
    user.id == record.user_id
  end

  def general?
    user.id == record[0].user_id || user.friendships.find_by(friend_id: record[0].user_id)
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
