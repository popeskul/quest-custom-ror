# frozen_string_literal: true

# Mailer for Notification
class UserMailer < ApplicationMailer
  default from: Settings.mail.from

  def signup_by_email(email)
    @email = email

    mail to: @email, subject: t('user_mailer.signup_by_email.subject')
  end
end
