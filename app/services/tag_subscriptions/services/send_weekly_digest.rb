# frozen_string_literal: true

# SendWeeklyDigest service
# Use cases:
# - when need to send weekly an email with new events for each tag subscriptions
# examples:
# - TagSubscriptions::Services::SendWeeklyDigest.new.call

module TagSubscriptions
  module Services
    # implement SendWeeklyDigest
    class SendWeeklyDigest
      def call
        TagSubscription.find_each(batch_size: 500) do |tag_subscription|
          TagSubscriptions::Services::SendEmailNewEvents.new(tag_subscription).call
        end
      end
    end
  end
end
