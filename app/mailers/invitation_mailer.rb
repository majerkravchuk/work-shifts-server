class InvitationMailer < ApplicationMailer
  def invitation(invitation)
    @invitation = invitation
    @manager = invitation.manager
    @business = invitation.business
    @template = ERB.new(EmailTemplate.email_template_for('invitation').body).result(binding).html_safe

    mail(to: @invitation.email, subject: 'Invitation to join')
  end
end
