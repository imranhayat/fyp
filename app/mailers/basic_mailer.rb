class BasicMailer < ApplicationMailer

  def confirmation_email(user)
    @email = user.email
    @user = user
    mail(to: @email, subject: "Your account has been confirmed!")
  end

end
