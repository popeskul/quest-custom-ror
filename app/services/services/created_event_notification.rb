# frozen_string_literal: true

require 'mailgun-ruby'

# Service for Notification
module Services
  # Implement Notification
  class CreatedEventNotification < ApplicationMailer
    def call(event)
      admins = User.where(admin: true)

      admins.each do |admin|
        NotificationMailer.event_created(admin, event).deliver_later
      end
    end
  end
end
