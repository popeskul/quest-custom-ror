# frozen_string_literal: true

# Mailer for Notification
class NotificationMailer < ApplicationMailer
  default from: Settings.mail.from

  def event_created(admin, event)
    @event = event
    @user = admin

    mail to: @user.email, subject: t('notification_mailer.event_created.subject')
  end
end
