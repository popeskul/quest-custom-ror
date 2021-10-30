# frozen_string_literal: true

# Service for Notification
module Services
  # Implement Notification
  class CreatedEventNotification < ApplicationMailer
    def call(event)
      admins = Staff.all

      admins.each do |admin|
        NotificationMailer.event_created(admin, event).deliver_later
      end
    end
  end
end
