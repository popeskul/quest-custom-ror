# frozen_string_literal: true

require 'mailgun-ruby'

# Service for Notification
module Services
  # Implement Notification
  class Notification < ApplicationMailer
    # Rails.application.credentials.config[:mailgun][:api_key]

    def send_notification(event)
      admins = User.where(admin: true)

      admins.find_each do |admin|
        NotificationMailer.event_created(admin, event).deliver_later
      end
    end
  end
end
