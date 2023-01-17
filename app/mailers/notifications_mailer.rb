require 'sendgrid-ruby'
include SendGrid


class NotificationsMailer < ApplicationMailer
	default :from => ENV['NOTIFICATIONS_FROM_EMAIL']
	def submission_alert(rainwork)
		# @rainwork = rainwork
		# mail :to => ENV['NOTIFICATIONS_TO_EMAIL'], :subject=> 'Someone submitted a rainwork'

		from = SendGrid::Email.new(email: ENV['NOTIFICATIONS_FROM_EMAIL'])
		to = SendGrid::Email.new(email: ENV['NOTIFICATIONS_TO_EMAIL'])
		subject = 'Sending with Twilio SendGrid is Fun'
		content = SendGrid::Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
		mail = SendGrid::Mail.new(from, subject, to, content)

		sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
		response = sg.client.mail._('send').post(request_body: mail.to_json)
		puts response.status_code
		puts response.body
		puts response.parsed_body
		puts response.headers
	end

	def edit_alert(rainwork)
		@rainwork = rainwork
		mail :to => ENV['NOTIFICATIONS_TO_EMAIL'], :subject=> 'Someone edited a rainwork'
	end

	def report_alert(report)
		@report = report
		mail :to => ENV['NOTIFICATIONS_TO_EMAIL'], :subject => "Someone reported a rainwork: #{@report.report_type}"
	end
end

