class UserMailerPreview < ActionMailer::Preview
  def invitation
    UserMailer.invitation(User.first)
  end
end
