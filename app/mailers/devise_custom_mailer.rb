class DeviseCustomMailer < Devise::Mailer
  default from: 'myshiftbank@gmail.com'
  layout 'mailer'
end
