class AllowedEmailPolicy < ApplicationPolicy
  def index?
    current_user.admin? || current_user.manager?
  end

  def show?
    current_user.admin? ||
    current_user.manager? && record.employee? && current_user.employee_positions.include?(record.position)
  end

  def create?
    current_user.admin? || current_user.manager?
  end

  def new?
    current_user.admin? || current_user.manager?
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

  def invite?
    show?
  end

  def reject_invitation?
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
      if current_user.admin?
        scope.where(business: current_user.business)
      elsif current_user.manager?
        scope.where(business: current_user.business).where(
          role: :employee,
          position_id: current_user.employee_positions
        )
      else
        []
      end
    end
  end
end
