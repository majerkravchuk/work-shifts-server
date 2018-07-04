class InvitationMailer < ApplicationMailer
  def invitation(invitation)
    @invitation = invitation
    @manager = invitation.manager
    @business = invitation.business

    mail(
      to: @invitation.email,
      subject: 'Invitation to join',
      body: ERB.new(EmailTemplate.email_template_for('invitation').body).result(binding).html_safe,
      content_type: 'text/html'
    )
  end
end
