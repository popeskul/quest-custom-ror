# frozen_string_literal: true

# Preview for TagSubscription Mailer
class TagSubscriptionMailerPreview < ActionMailer::Preview
  def subscription_created
    TagSubscriptionMailer.subscription_created(TagSubscription.first)
  end

  def digest
    TagSubscriptionMailer.digest(TagSubscription.first, Event.first(2))
  end
end
