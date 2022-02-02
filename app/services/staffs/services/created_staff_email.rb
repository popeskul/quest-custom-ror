# frozen_string_literal: true

# Service for CreatedStaffEmail
# examples:
# - Staffs::Services::CreatedStaffEmail.new(staff).call

module Staffs
  module Services
    # Implement Notification
    class CreatedStaffEmail < ApplicationMailer
      def call(staff)
        @staff = staff

        @staff.send_reset_password_instructions
      end
    end
  end
end
