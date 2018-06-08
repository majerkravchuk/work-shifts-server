class PositionPolicy < ApplicationPolicy
  def index?
    current_user.super_admin?
  end

  def show?
    current_user.super_admin?
  end

  def create?
    current_user.super_admin?
  end

  def new?
    current_user.super_admin?
  end

  def update?
    current_user.super_admin?
  end

  def edit?
    current_user.super_admin?
  end

  def destroy?
    current_user.super_admin?
  end
end
