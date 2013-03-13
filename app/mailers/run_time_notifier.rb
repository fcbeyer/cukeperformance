class RunTimeNotifier < ActionMailer::Base
  default from: "cukes@patientkeeper.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.run_time_notifier.bvt.subject
  #
  def bvt
    @greeting = "Hi"

    mail to: "rbeyer@patientkeeper.com", subject: 'Your Stuff is Busted'
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
end
