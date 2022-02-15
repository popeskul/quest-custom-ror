# frozen_string_literal: true

# Service for SendCreatedEventEmail
# Use cases:
# - when need to send an email notification after an event was created
# examples:
# - Staffs::Services::SendCreatedEventEmail.new(event).call

module Staffs
  module Services
    # Implement SendCreatedEventEmail
    class SendCreatedEventEmail < ApplicationMailer
      def call(event)
        admins = Staff.all

        admins.each do |admin|
          NotificationMailer.event_created(admin, event).deliver_later
        end
      end
    end
  end
end
