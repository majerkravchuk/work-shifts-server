class EmailTemplate::TemplatePolicy < ApplicationPolicy
  def index?
    current_user.super_admin?
  end

  def update?
    current_user.super_admin?
  end

  def edit?
    current_user.super_admin?
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
      scope.where(business: current_user.business)
    end
  end
end
