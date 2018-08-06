module Api
  module Auth
    class SessionsController < Devise::SessionsController
      protect_from_forgery unless: -> { request.format.json? }
      skip_before_action :verify_authenticity_token

      # POST /api/auth/sign-in
      def create
        resource = warden.authenticate(scope: :user, recall: 'api/sessions#new')
        if resource.present?
          sign_in(:user, resource)
          render json: CurrentUserSerializer.new(resource)
        else
          render json: { error: 'Invalid email or password' }, status: 422
        end
      end

      # DELETE /api/auth/sign-out
      def destroy
        sign_out(:user)
        head :ok
      end
    end
  end
end

