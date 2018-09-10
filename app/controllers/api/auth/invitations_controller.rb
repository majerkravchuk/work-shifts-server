module Api
  module Auth
    class InvitationsController < ApiController
      skip_before_action :authenticate

      # GET /api/auth/invitation?token=token...
      def show
        user = User.find_by(invitation_token: params[:token])

        if user.nil?
          render_client_errors('User with this invitation token does not exist.', :not_found)

        elsif user.uploaded?
          render_client_errors('User is uploaded to the system, but not yet invited.', :unprocessable_entity)

        elsif user.accepted?
          render_client_errors('User has already accepted the invitation.', :unprocessable_entity)

        elsif user.invited?
          render json: UserSerializer.new(user)

        else
          render_client_errors('Something went wrong. Please contact your administrator.')
        end
      end
    end
  end
end

