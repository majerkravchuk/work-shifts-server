module Api
  module Auth
    class PasswordsController < Devise::PasswordsController
      include ApiResponsable

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
          render_client_errors('User with this email does not exist', :unprocessable_entity)
        end
      end

      # PUT /api/password
      def update
        self.resource = resource_class.reset_password_by_token(reset_password_params)

        if resource.errors.empty?
          sign_in(:user, resource)
          render json: CurrentUserSerializer.new(resource)
        else
          render_client_errors(resource.errors.messages.values.flatten.first, :unprocessable_entity)
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
