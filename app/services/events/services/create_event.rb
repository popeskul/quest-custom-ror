# frozen_string_literal: true

# Service for CreateEvent
# Use cases:
# - when need to create an event
# examples:
# - Events::Services::CreateEvent.new(user, {})
# - options for events and tag_list
# results: Event or Event with errors

module Events
  module Services
    # Implement CreateEvent
    class CreateEvent
      attr_reader :event

      def initialize(user, options = {})
        @event = user.events.new(options)
        @event.tag_list.add(options[:tag_list])
      end

      def call
        @event.tap do |event|
          event.tag_list.add(find_tags_in_description)
          send_email if event.save
        end
      end

      private

      def send_email
        Staffs::Services::SendCreatedEventEmail.call(@event).deliver
      end

      def find_tags_in_description
        Tags::Queries::SearchByTags.new(@event.description, ActsAsTaggableOn::Tag.all).call
      end
    end
  end
end
