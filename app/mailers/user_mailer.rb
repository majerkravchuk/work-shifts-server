class UserMailer < ApplicationMailer
  def invitation(user)
    @user = user
    @manager = user.inviter
    @business = user.business
    @token = user.invitation_token

    mail(to: @user.email, subject: 'Invitation to join')
  end
end
