# frozen_string_literal: true

# Preview for Notification Mailer
class NotificationMailerPreview < ActionMailer::Preview
  def event_created
    NotificationMailer.event_created(User.first, Event.first)
  end
end
