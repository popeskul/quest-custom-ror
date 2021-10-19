# frozen_string_literal: true

# Service for CreateEvent
module Services
  # Implement CreateEvent
  class CreateEvent
    attr_reader :event

    def initialize(options = {})
      @event = Event.new(options)
    end

    def call
      @event.save
      send_email
      @event
    end

    private

    def send_email
      Services::CreatedEventNotification.call(@event).deliver
    end
  end
end
