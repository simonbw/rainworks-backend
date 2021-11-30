require 'sendgrid-ruby'
include SendGrid
require 'json'

class NotificationsMailer < ApplicationMailer
	default :from => ENV['NOTIFICATIONS_FROM_EMAIL']

	

	def submission_alert(rainwork)
		@rainwork = rainwork
		# mail :to => ENV['NOTIFICATIONS_TO_EMAIL'], :subject=> 'Someone submitted a rainwork'
		from = Email.new(email: ENV['NOTIFICATIONS_FROM_EMAIL'])
		subject = 'Someone submitted a rainwork'
		to = Email.new(email: ENV['NOTIFICATIONS_TO_EMAIL'])
		mail = SendGrid::Mail.new(from, subject, to, @rainwork)
		puts mail.to_json
	  
		sg = SendGrid::API.new(api_key: ENV['SENDGRID_PASSWORD'])
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
