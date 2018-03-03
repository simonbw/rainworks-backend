class NotificationsMailer < ApplicationMailer
	default from: 'notifications@rain.works'

	def submission_alert(rainwork)
		@rainwork = rainwork
		mail to: "thecheeseinator@gmail.com", subject: "Test Notification"
	end

	def report_alert(report)
		@report = report
		mail to: "thecheeseinator@gmail.com", subject: "Test Notification"
	end
end
