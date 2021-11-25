class NotificationsMailer < ApplicationMailer
	default from: ENV['NOTIFICATIONS_FROM_EMAIL']
	def submission_alert(rainwork)
		@rainwork = rainwork
		mail (subject: 'Someone submitted a rainwork')
	end

	def report_alert(report)
		@report = report
		mail subject: "Someone reported a rainwork: #{@report.report_type}"
	end
end
