# frozen_string_literal: true

# ModerationEvent service
# examples:
# - Events::Services::ModerationEvent.new(event)

module Events
  module Services
    # implement base ModerationEvent Services
    class ModerationEvent
      attr_reader :event

      def initialize(event)
        @event = event
      end
    end
  end
end
