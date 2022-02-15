# frozen_string_literal: true

# Service for UpdatedStaffEmail
# Use cases:
# - when need to send an email after a staff was updated
# examples:
# - Staffs::Services::UpdatedStaffEmail.new(staff).call

module Staffs
  module Services
    # Implement UpdatedStaffEmail
    class UpdatedStaffEmail < ApplicationMailer
      def call(staff)
        @staff = staff

        StaffMailer.staff_updated(@staff).deliver_later
      end
    end
  end
end
