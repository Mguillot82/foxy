class CatchPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    record.user_id == user.id || (user.friendships.find_by(friend_id: record.user_id) && (user.friendships.find_by(friend_id: record.user_id).status == 'accepted'))
  end

  def create?
    record.user_id == user.id
  end
end
