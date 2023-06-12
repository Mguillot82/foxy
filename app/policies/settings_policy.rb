class SettingsPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end

    def index?
      user.present?
    end

    #def show?
     # record.id == user.id
    #end
  end
end
