# frozen_string_literal: true

# Preview for Notification Mailer
class StaffMailerPreview < ActionMailer::Preview
  def staff_updated
    StaffMailer.staff_updated(Staff.first)
  end
end
