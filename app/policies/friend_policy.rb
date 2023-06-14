class FriendPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      user.friendships.where(status: "accepted").map(&:friend)
    end
  end

  def show?
    # record.id == user.id
    # pour voir la show d'un ami il faut etre ami avec
    user.friends.include?(record)
  end

  def create?
    record.user == user
  end

  def update?
    user.friends.include?(record.friend)
  end

  def destroy?
    user.friends.include?(record.friend)
  end

  def new?
    create?
  end

  def invite?
    true
  end

  def friends_requests?
    true
  end

  def reject?
    !Friendship.where(user: record, friend: user).empty?
  end

  def add?
    !Friendship.where(user: record, friend: user).empty?
  end
end
