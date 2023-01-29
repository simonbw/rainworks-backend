require 'sendgrid-ruby'
include SendGrid


class NotificationsMailer < ApplicationMailer
	default :from => ENV['NOTIFICATIONS_FROM_EMAIL']

	def submissions_alert(rainwork)
		@rainwork = rainwork
		subject = 'Hello World from the Twilio SendGrid Ruby Library'
		to = Email.new(email: ENV['NOTIFICATIONS_TO_EMAIL'])
		content = Content.new(type: 'text/plain', value: 'some text here')
		mail = SendGrid::Mail.new(from, subject, to, content)
		puts JSON.pretty_generate(mail.to_json)
		puts mail.to_json
	
		sg = SendGrid::API.new(api_key: ENV['SENDGRID_PASSWORD'])
		response = sg.client.mail._('send').post(request_body: mail.to_json)
		puts response.status_code
		puts response.body
		puts response.headers
		# mail :to => ENV['NOTIFICATIONS_TO_EMAIL'], :subject=> 'Someone submitted a rainwork'
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