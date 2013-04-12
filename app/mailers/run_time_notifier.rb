class RunTimeNotifier < ActionMailer::Base
  default from: "cukes@patientkeeper.com"
  add_template_helper(TaskAlertsHelper)

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.run_time_notifier.bvt.subject
  #
  def bvt
  	@greeting = "Hi"
  	
    mail to: "rbeyer@patientkeeper.com", subject: "Cuke Performance BVT Alert"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.run_time_notifier.portalsmoke.subject
  #
  def portalsmoke
    @greeting = "Hi"

    mail to: "teamverve@patientkeeper.com", subject: "Cuke Performance Portal Smoke Alert"
  end
  
  
  def suite_alert(task,current_alert,average,suite_list)
  	alert_subject = "Cuke Performance " + task.display_name + " Alert"
  	@email_alert_task = current_alert
  	@email_task = task
  	@average = average
  	@email_suite_list = suite_list
  	emails = process_email_list(current_alert)
  	
  	mail to: emails, subject: alert_subject
  end
  
  def process_email_list(current_alert)
		list = current_alert.email_list.split(",")
		list.each_with_index do |entry,entry_num|
			#stuff
			list[entry_num] = entry + "@patientkeeper.com"
		end
		return list
	end
	
end
