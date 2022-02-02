# frozen_string_literal: true

# FindNewEvents service
# examples:
# - Events::Queries::FindNewEvents.new(tag_subscription).call
# results: [], [Event, Event, ...]

module Events
  module Queries
    # Implement FindNewEvents
    class FindNewEvents
      LIMIT_OF_EVENTS = 5

      def initialize(tag_subscription)
        @tag_subscription = tag_subscription
      end

      def call
        ids_for_search = subscription_events.map(&:id) - delivered_events.map(&:event_id)
        Event.find(ids_for_search)&.first(LIMIT_OF_EVENTS)
      end

      private

      def user
        @user ||= User.find_by_email(@tag_subscription.email)
      end

      def tags
        @tags ||= TagSubscription.find_tags(@tag_subscription.tags)
      end

      def delivered_events
        DeliveredUserEvent.delivered_by(event_id: subscription_events.map(&:id), user_id: user.id)
      end

      def subscription_events
        ids = taggings.flatten.reject(&:nil?).map(&:taggable_id).uniq
        Event.find(ids)
      end

      def taggings
        tags.map { |tag| tag.taggings&.where(taggable_type: 'Event') }
      end
    end
  end
end
