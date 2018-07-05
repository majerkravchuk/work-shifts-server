class AdministratorPolicy < UserPolicy
  def update?
    current_user.administrator? && record == current_user
  end

  def edit?
    current_user.administrator? && record == current_user
  end

  def reset_password?
    @current_user.administrator? && @current_user.super_administrator?
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
