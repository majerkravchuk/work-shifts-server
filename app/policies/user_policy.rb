class UserPolicy < ApplicationPolicy
  def reset_password?
    @current_user.super_admin? || @current_user.manager?
  end

  class Scope
    attr_reader :current_user, :scope

    def initialize(current_user, scope)
      @current_user = current_user
      @scope = scope
    end

    def resolve
      @scope = @scope.where(business: current_user.business).where.not(role: :super_admin)

      if current_user.manager?
        @scope = @scope.where(position: current_user.position.allowed_employee_positions)
      end

      scope
    end
  end
end
