# frozen_string_literal: true

# Mailer for TagSubscription
class TagSubscriptionMailer < ApplicationMailer
  default from: Settings.mail.from

  def subscription_created(tag_subscription)
    @email = tag_subscription.email
    @tags = tag_subscription.tags

    mail to: @email, subject: t('tag_subscription_mailer.subscription_created.subject')
  end

  def digest(tag_subscription, events)
    @email = tag_subscription.email
    @tags = tag_subscription.tags
    @events = events

    mail to: @email, subject: t('tag_subscription_mailer.digest.subject')
  end
end
