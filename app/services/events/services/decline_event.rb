# frozen_string_literal: true

# DeclineEvent service
# Use cases:
# - when need to decline an event
# examples:
# - Events::Services::DeclineEvent.new(event)

module Events
  module Services
    # implement DeclineEvent Services
    class DeclineEvent < ModerationEvent
      def call
        return false if @event.declined?

        @event.decline!
      end
    end
  end
end
