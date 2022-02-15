# frozen_string_literal: true

# Service for UpdateNotification
# Use case:
# - when user updates a staff account and send an email
# examples:
# - Staffs::Services::UpdateNotification.new(staff, options).call

module Staffs
  module Services
    # Implement UpdateNotification
    class UpdateNotification
      attr_reader :staff

      def initialize(staff, options = {})
        @staff = staff
        @options = options
      end

      def call
        @staff.tap do |staff|
          staff.update(@options)
          send_email if staff.valid?
        end
      end

      private

      def send_email
        Staffs::Services::UpdatedStaffEmail.call(@staff).deliver
      end
    end
  end
end
