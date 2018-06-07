class PositionPolicy < ApplicationPolicy
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
end
