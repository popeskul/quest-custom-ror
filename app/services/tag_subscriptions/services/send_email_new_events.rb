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

        if delivered_tag_subscription
          update(events)
        else
          create(events)
        end
      end

      private

      def user
        @user ||= User.find_by_email(@tag_subscription.email)
      end

      def delivered_tag_subscription
        @delivered_tag_subscription ||= DeliveredTagSubscription.find_by(tag_subscription_id: @tag_subscription.id)
      end

      def update(events)
        delivered_ids = delivered_tag_subscription.event_ids.map(&:to_i)
        delivered_tag_subscription.update(event_ids: events.map(&:id).concat(delivered_ids))
      end

      def create(events)
        DeliveredTagSubscription.create(
          event_ids: events.map(&:id),
          email: user.email,
          tag_subscription_id: @tag_subscription.id
        )
      end
    end
  end
end
