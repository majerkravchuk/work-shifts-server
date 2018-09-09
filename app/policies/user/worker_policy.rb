class User
  class WorkerPolicy < UserPolicy
    class Scope
      attr_reader :current_user, :scope

      def initialize(current_user, scope)
        @current_user = current_user
        @scope = scope
      end

      def resolve
        @scope.where(business: @current_user.business)
      end
    end
  end
end
