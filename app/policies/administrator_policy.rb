class AdministratorPolicy < UserPolicy
  def update?
    current_user.admin? && record == current_user
  end

  def edit?
    current_user.admin? && record == current_user
  end

  def reset_password?
    @current_user.admin? && @current_user.super_admin?
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
