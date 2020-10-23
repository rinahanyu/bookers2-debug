class DailyMailer < ApplicationMailer
  default from: "gravity0112@gmail.com"

  def notify_user
    default to: -> { User.pluck(:email) }
    mail(subject: "everybody! Do you use bookers?")
  end
end
