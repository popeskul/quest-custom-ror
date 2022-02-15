# frozen_string_literal: true

# Service CreateStaff
# examples:
# - Staffs::Services::CreateStaff.new(options).call
# - options it's params from Staff model
# - if no password then we put by default

module Staffs
  module Services
    # Implement CreateStaff
    class CreateStaff
      PASSWORD = Faker::Internet.password(min_length: 8)

      def initialize(options = {})
        options_with_password = options.merge(password: PASSWORD, password_confirmation: PASSWORD)
        @staff = Staff.new(options[:password] ? options : options_with_password)
      end

      def call
        @staff.tap { |_| send_email if @staff.save }
      end

      private

      def send_email
        @staff.send_reset_password_instructions
      end
    end
  end
end
