# frozen_string_literal: true

# Service for SendCreatedEventEmail
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
