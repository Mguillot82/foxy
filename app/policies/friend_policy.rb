class FriendPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      user.friends
    end
  end

  def show?
    record.id == user.id
  end
end
