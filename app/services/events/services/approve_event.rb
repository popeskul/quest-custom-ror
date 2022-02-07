# frozen_string_literal: true

# ApproveEvent service
# examples:
# - Events::Services::ApproveEvent.new(event)

module Events
  module Services
    # implement ApproveEvent Services
    class ApproveEvent < ModerationEvent
      def call
        return false if @event.approved?

        @event.approve!
      end
    end
  end
end
