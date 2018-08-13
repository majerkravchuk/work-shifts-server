module Api
  module Auth
    class PasswordsController < Devise::PasswordsController
      protect_from_forgery unless: -> { request.format.json? }
      skip_before_action :verify_authenticity_token

      # POST /api/password
      def create
        self.resource = resource_class.send_reset_password_instructions(resource_params)

        if successfully_sent?(resource)
          render json: {
            message: 'You will receive instructions on how to reset your password in a few minutes'
          }, status: 201
        else
          render json: { error: 'The user with this email does not exist' }, status: 422
        end
      end

      # PUT /api/password
      def update
        self.resource = resource_class.reset_password_by_token(reset_password_params)

        if resource.errors.empty?
          sign_in(:user, resource)
          render json: CurrentUserSerializer.new(resource)
        else
          render json: { error: resource.errors.messages.values.flatten.first }, status: 422
        end
      end

      private

      def resource_params
        params.fetch(:user, {})
      end

      def reset_password_params
        params.require(:password).permit(:reset_password_token, :password, :password_confirmation)
      end
    end
  end
end
