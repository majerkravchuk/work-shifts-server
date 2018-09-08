class BusinessPolicy < ApplicationPolicy
  def index?
    current_user.admin?
  end

  def show?
    current_user.admin?
  end

  def create?
    current_user.admin?
  end

  def new?
    current_user.admin?
  end

  def update?
    current_user.admin?
  end

  def edit?
    current_user.admin?
  end

  def destroy?
    current_user.admin?
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
      scope
    end
  end
end
