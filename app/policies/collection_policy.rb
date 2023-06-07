class CollectionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user_id: user.id)
    end
  end

  def index?
    user.id == record.user_id
  end

  def show?
    user.id == record.user_id
  end

  def general?
    user.id == record.user_id
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
