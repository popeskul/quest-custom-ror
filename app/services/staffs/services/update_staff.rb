# frozen_string_literal: true

# Service for UpdateStaff
# examples:
# - Staffs::Services::UpdateStaff.new(staff, options).call

module Staffs
  module Services
    # Implement UpdateStaff
    class UpdateStaff
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
