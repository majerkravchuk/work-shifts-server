class User
  class AdminPolicy < ApplicationPolicy
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

    def edit?
      current_user.super_admin?
    end

    def destroy?
      current_user.super_admin?
    end

    def invite?
      current_user.super_admin?
    end

    def reset_password?
      current_user.super_admin?
    end

    class Scope
      attr_reader :current_user, :scope

      def initialize(current_user, scope)
        @current_user = current_user
        @scope = scope
      end

      def resolve
        current_user.super_admin? ? @scope.where(type: 'User::Admin') : []
      end
    end
  end
end
