# frozen_string_literal: true

# Service for CreateEvent
module Services
  # Implement CreateEvent
  class CreateEvent
    attr_reader :event

    def initialize(user, options = {})
      @event = user.events.new(options)
    end

    def call
      @event.save.tap do |_|
        send_email if @event.valid?
      end

      @event
    end

    private

    def send_email
      Services::CreatedEventNotification.call(@event).deliver
    end
  end
end
