# frozen_string_literal: true

# Service for CreateEvent
module Services
  # Implement CreateEvent
  class CreateEvent
    attr_reader :event

    def initialize(user, options = {})
      @event = user.events.new(options)
      @event.tag_list.add(options[:tag_list])
    end

    def call
      @event.tag_list.add(find_tags_in_description)

      @event.save.tap do |_|
        send_email if @event.valid?
      end

      @event
    end

    private

    def send_email
      Services::CreatedEventNotification.call(@event).deliver
    end

    def find_tags_in_description
      Services::SearchByTags.new(@event.description, ActsAsTaggableOn::Tag.all.map(&:name)).call
    end
  end
end
