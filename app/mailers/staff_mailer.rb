# frozen_string_literal: true

# Mailer for Notification
class StaffMailer < ApplicationMailer
  default from: Settings.mail.from

  def staff_updated(staff)
    @staff = staff

    mail to: @staff.email, subject: t('staff_mailer.staff_updated.subject')
  end
end
