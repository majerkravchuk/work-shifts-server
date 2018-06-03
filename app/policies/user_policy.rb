class UserPolicy < ApplicationPolicy
  class Scope
    attr_reader :current_user, :scope

    def initialize(current_user, scope)
      @current_user = current_user
      @scope = scope
    end

    def resolve
      scope.where(business: current_user.business).where.not(role: :admin)
    end
  end
end
