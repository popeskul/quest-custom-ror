# frozen_string_literal: true

# Preview for User Mailer
class UserMailerPreview < ActionMailer::Preview
  def signup_by_email
    UserMailer.signup_by_email(TagSubscription.first)
  end
end
