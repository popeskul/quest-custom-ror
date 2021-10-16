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
      NotificationMailer.event_created(@event.author, @event).deliver
    end

    def decline
      @event.decline!
      NotificationMailer.event_created(@event.author, @event).deliver
    end
  end
end
