class NotificationsMailer < ApplicationMailer
	default :from => ENV['NOTIFICATIONS_FROM_EMAIL']
	def submission_alert(rainwork)
		@rainwork = rainwork
		mail :to => ENV['NOTIFICATIONS_TO_EMAIL'], :subject=> 'Someone submitted a rainwork'
	end

	def edit_alert(rainwork)
		@rainwork = rainwork
		mail :to => ENV['NOTIFICATIONS_TO_EMAIL'], :subject=> 'Someone edited a rainwork'
	end

	def report_alert(report)
		@report = report
		mail :to => ENV['NOTIFICATIONS_TO_EMAIL'], subject => "Someone reported a rainwork: #{@report.report_type}"
	end
end
