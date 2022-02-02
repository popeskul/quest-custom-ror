# frozen_string_literal: true

# Event service
# examples:
# - Events::Services::ModerationEvent.new(event)
# - Events::Services::ModerationEvent.new(event).approve
# - Events::Services::ModerationEvent.new(event).decline

module Events
  # Service for Event::Services::CreateEvent
  module Services
    # implement Event Services
    class ModerationEvent
      attr_reader :event

      def initialize(event)
        @event = event
      end

      def approve
        return false if @event.approved?

        @event.approve!
      end

      def decline
        return false if @event.declined?

        @event.decline!
      end
    end
  end
end
