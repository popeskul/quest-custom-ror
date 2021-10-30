# frozen_string_literal: true

# Service for CreateEvent
module Services
  # Implement CreateEvent
  class UpdateStaff
    attr_reader :staff

    def initialize(staff, options = {})
      @staff = staff
      @options = options
    end

    def call
      @staff.update(@options).tap do |_|
        send_email if @staff.valid?
      end

      @staff
    end

    private

    def send_email
      Services::UpdatedStaffNotification.call(@staff).deliver
    end
  end
end
