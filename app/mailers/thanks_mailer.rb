class ThanksMailer < ApplicationMailer
  default from: "aaaaaa@gmail.com"

  def send_confirm_to_user(user)
    @user = user
    mail(
      subject: "会員登録が完了しました。",
      to: @user.email
      ) do |format|
        format.text
        end
  end
end
