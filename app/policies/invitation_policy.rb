class InvitationPolicy < ApplicationPolicy
  def index?
    current_user.super_admin? || current_user.manager?
  end

  def show?
    current_user.super_admin? ||
    current_user.manager? && current_user.allowed_employee_positions.include?(record.employee_position)
  end

  def create?
    show?
  end

  def new?
    current_user.super_admin? || current_user.manager?
  end

  def update?
    show?
  end

  def edit?
    show?
  end

  def destroy?
    show?
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
      if current_user.super_admin?
        scope.where(business: current_user.business)
      elsif current_user.manager?
        scope.where(business: current_user.business).where(employee_position_id: current_user.allowed_employee_positions)
      else
        []
      end
    end
  end
end
