class NotificationsMailer < ApplicationMailer
	default to: ENV['NOTIFICATIONS_TO_EMAIL']
	def submission_alert(rainwork)
		
# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid

from = Email.new(email: 'test@example.com')
to = Email.new(email: 'test@example.com')
subject = 'Sending with SendGrid is Fun'
content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
mail = Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers
	end

	def report_alert(report)
		@report = report
		mail subject: "Someone reported a rainwork: #{@report.report_type}"
	end
end
