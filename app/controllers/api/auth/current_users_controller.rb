module Api
  module Auth
    class CurrentUsersController < ApiController

      # GET /api/auth/current-user
      def show
        render json: current_user
      end
    end
  end
end

