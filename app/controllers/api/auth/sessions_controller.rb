module Api
  module Auth
    class SessionsController < Devise::SessionsController
      include ApiResponsable

      protect_from_forgery unless: -> { request.format.json? }
      skip_before_action :verify_authenticity_token

      # POST /api/auth/sign-in
      def create
        resource = warden.authenticate(scope: :user, recall: 'api/sessions#new')
        if resource.present?
          sign_in(:user, resource)
          render json: CurrentUserSerializer.new(resource, include: [:business])
        else
          render_client_errors('Invalid email or password', :unprocessable_entity)
        end
      end

      # DELETE /api/auth/sign-out
      def destroy
        if current_user.present?
          sign_out(:user)
          render_message('Signed out successfully')
        else
          render_client_errors('You are not authorized', :unauthorized)
        end
      end
    end
  end
end

