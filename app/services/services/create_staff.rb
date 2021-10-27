# frozen_string_literal: true

# Service for CreateStaff
module Services
  # Implement CreateStaff
  class CreateStaff
    attr_reader :staff

    def initialize(options = {})
      password = Faker::Internet.password(min_length: 8)
      options_with_password = options.merge(password: password, password_confirmation: password)

      @staff = Staff.new(options_with_password)
    end

    def call
      @staff.tap { |_| send_email if @staff.save }
    end

    private

    def send_email
      Services::CreatedStaffNotification.call(@staff).deliver
    end
  end
end
