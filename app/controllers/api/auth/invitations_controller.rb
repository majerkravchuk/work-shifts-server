module Api
  module Auth
    class InvitationsController < ApiController
      before_action :find_user_by_invitation_token, only: :show
      before_action :find_user_by_email, only: :create
      before_action :validate_invitation_status

      skip_before_action :authenticate

      # GET /api/auth/invitation?token=token...
      def show
        render json: UserSerializer.new(@user)
      end

      # POST /api/auth/invitation
      def create
        @user.assign_attributes user_params.merge({ invitation_status: :accepted })

        if @user.save
          render_message('Password successfully set', :created)
        else
          render_client_errors(@user.errors.messages.values.flatten, :unprocessable_entity)
        end
      end

      private

      def find_user_by_invitation_token
        @user = User.find_by invitation_token: params[:token]
        render_client_errors('User with this invitation token does not exist', :not_found) if @user.nil?
      end

      def find_user_by_email
        @user = User.find_by email: user_params[:email]
        render_client_errors('User with this email does not exist', :not_found) if @user.nil?
      end

      def validate_invitation_status
        if @user.uploaded?
          render_client_errors('User is uploaded to the system, but not yet invited', :unprocessable_entity)
        elsif @user.accepted?
          render_client_errors('User has already accepted the invitation', :unprocessable_entity)
        end
      end

      def user_params
        params.require(:user).permit(:email, :name, :password, :password_confirmation)
      end
    end
  end
end

