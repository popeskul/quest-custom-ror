# frozen_string_literal: true

# Event service
module Services
  # implement Reputation
  class Event
    attr_reader :event

    def initialize(event)
      @event = event
    end

    def approve
      @event.approve!
    end

    def decline
      @event.decline!
    end
  end
end
