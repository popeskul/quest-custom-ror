# frozen_string_literal: true

# Service for Notification
module Services
  # Implement Notification
  class CreatedStaffNotification < ApplicationMailer
    def call(staff)
      @staff = staff

      @staff.send_reset_password_instructions
    end
  end
end
