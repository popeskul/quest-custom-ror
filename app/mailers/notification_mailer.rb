# frozen_string_literal: true

require 'mailgun-ruby'

# Mailer for Notification
class NotificationMailer < ApplicationMailer
  default from: 'me@qustom-ror.org'

  def event_created(admin, event)
    @event = event
    @user = admin

    mail to: @user.email, subject: t('notification_mailer.event_created.subject')
  end
end
