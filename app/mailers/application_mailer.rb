class ApplicationMailer < ActionMailer::Base
  default from: ENV['NOTIFICATIONS_FROM_EMAIL']
  layout 'mailer'
end
