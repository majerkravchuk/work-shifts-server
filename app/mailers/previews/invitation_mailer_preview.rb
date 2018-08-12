class InvitationMailerPreview < ActionMailer::Preview
  def invitation
    InvitationMailer.invitation(Invitation.first)
  end
end
