class ShiftPolicy < ApplicationPolicy
  def index?
    current_user.admin? || current_user.manager?
  end

  def show?
    current_user.admin? || current_user.manager?
  end

  def create?
    current_user.admin? || current_user.manager?
  end

  def new?
    current_user.admin? || current_user.manager?
  end

  def update?
    current_user.admin? || current_user.manager?
  end

  def edit?
    current_user.admin? || current_user.manager?
  end

  def destroy?
    current_user.admin? || current_user.manager?
  end

  def scope
    Pundit.policy_scope!(current_user, record.class)
  end

  class Scope
    attr_reader :current_user, :scope

    def initialize(current_user, scope)
      @current_user = current_user
      @scope = scope
    end

    def resolve
      if current_user.admin?
        scope.where(business: current_user.business)
      elsif current_user.manager?
        scope.where(business: current_user.business).where(position: current_user.employee_positions)
      else
        []
      end
    end
  end
end
