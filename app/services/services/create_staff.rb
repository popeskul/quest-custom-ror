# frozen_string_literal: true

# Service for CreateStaff
module Services
  # Implement CreateStaff
  class CreateStaff
    attr_reader :staff

    def initialize(options = {})
      options_with_password = options.merge(password: Faker::Internet.password(min_length: 8))
      @staff = Staff.new(options_with_password)
    end

    def call
      @staff.save.tap { |_| send_email if @staff.valid? }

      @staff
    end

    private

    def send_email
      Services::CreatedStaffNotification.call(@staff).deliver
    end
  end
end
