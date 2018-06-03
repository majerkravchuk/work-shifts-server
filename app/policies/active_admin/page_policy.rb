module ActiveAdmin
  class PagePolicy < ApplicationPolicy
    class Scope < Struct.new(:current_user, :scope)
      def resolve
        scope
      end
    end

    def show?
      current_user.admin? || current_user.manager?
    end
  end
end
