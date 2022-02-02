# frozen_string_literal: true

# Service for SendNewEvents
# examples:
# - TagSubscriptions::Services::SendNewEvents.new(tag_subscription).call

module TagSubscriptions
  module Services
    # implement SendNewEvents service
    class SendEmailNewEvents
      def initialize(tag_subscription)
        @tag_subscription = tag_subscription
      end

      def call
        events = Events::Queries::FindNewEvents.new(@tag_subscription).call

        return unless events.present?

        TagSubscriptions::Services::WeeklyTagDigest.new.send_digest(@tag_subscription, events)

        save_sent_events(events)
      end

      private

      def user
        @user ||= User.find_by_email(@tag_subscription.email)
      end

      def save_sent_events(events)
        events.map { |event| DeliveredUserEvent.create!(event: event, user: user) }
      end
    end
  end
end
