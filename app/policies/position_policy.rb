class PositionPolicy < ApplicationPolicy
  def index?
    current_user.administrator?
  end

  def show?
    current_user.administrator?
  end

  def create?
    current_user.administrator?
  end

  def new?
    current_user.administrator?
  end

  def update?
    current_user.administrator?
  end

  def edit?
    current_user.administrator?
  end

  def destroy?
    current_user.administrator?
  end
end
