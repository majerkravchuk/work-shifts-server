module Api
  class SessionsController < ApiController

    # POST /api/sign-in
    def create
      user = User.find_by email: session_params[:email]

      if user.present? && user.valid_password?(session_params[:password])
        render json: { jwt: Auth.issue(user.jwt_payload) }
      else
        render json: { error: 'Invalid email or password' }, status: 422
      end
    end

    private

    def session_params
      params.require(:session).permit(:email, :password)
    end
  end
end
