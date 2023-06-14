class BadgePolicy < ApplicationPolicy
  class Scope < Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def grant_user_badge?
    true
  end
end
