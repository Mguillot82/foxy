class FriendPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      user.friends
    end
  end

  def show?
    # record.id == user.id
    # pour voir la show d'un ami il faut etre ami avec
    true
  end

  def friends_requests?
    true
  end

  def reject?
    user.friends.include?(record)
  end

  def add?
    user.friends.include?(record)
  end
end
