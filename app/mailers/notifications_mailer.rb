class NotificationsMailer < ApplicationMailer
	default to: ENV['NOTIFICATIONS_TO_EMAIL']
	def submission_alert(rainwork)
		@rainwork = rainwork
		mail subject: 'Someone submitted a rainwork'
	end

	def report_alert(report)
		@report = report
		mail subject: "Someone reported a rainwork: #{@report.report_type}"
	end
end
