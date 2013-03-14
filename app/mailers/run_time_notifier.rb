class RunTimeNotifier < ActionMailer::Base
  default from: "cukes@patientkeeper.com"
  add_template_helper(TaskAlertsHelper)

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.run_time_notifier.bvt.subject
  #
  def bvt
  	
  	
    mail to: "rbeyer@patientkeeper.com", subject: "Cuke Performance BVT Alert"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.run_time_notifier.portalsmoke.subject
  #
  def portalsmoke
    @greeting = "Hi"

    mail to: "teamverve@patientkeeper.com"
  end
  
  
  def suite_alert(task,current_alert,average)
  	alert_subject = "Cuke Performance " + task.display_name + " Alert"
  	@email_alert_task = current_alert
  	@email_task = task
  	@average = average
  	
  	mail to: "rbeyer@patientkeeper.com", subject: alert_subject
  end
end
