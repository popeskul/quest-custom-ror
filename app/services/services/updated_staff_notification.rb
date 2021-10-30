# frozen_string_literal: true

# Service for Notification
module Services
  # Implement Notification
  class UpdatedStaffNotification < ApplicationMailer
    def call(staff)
      @staff = staff

      StaffMailer.staff_updated(@staff).deliver_later
    end
  end
end
