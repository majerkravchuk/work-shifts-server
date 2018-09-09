class InvitationMailer < ApplicationMailer
  def invitation(user)
    @user = user
    @manager = user.inviter
    @business = user.business
    @token = user.invitation_token
    @template = ERB.new(EmailTemplate.email_template_for('invitation').body).result(binding).html_safe

    mail(to: @invitation.email, subject: 'Invitation to join')
  end
end
