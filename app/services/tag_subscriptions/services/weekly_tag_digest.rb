# frozen_string_literal: true

# WeeklyTagDigestMailer service
# Use cases:
# - when need to send a tag subscription Mailer
# examples:
# - TagSubscriptions::Services::WeeklyTagDigest.new(tag_subscription, events).call

module TagSubscriptions
  module Services
    # implement WeeklyTagDigestMailer
    class WeeklyTagDigest
      def send_digest(tag_subscription, events)
        TagSubscriptionMailer.digest(tag_subscription, events).deliver_later
      end
    end
  end
end
