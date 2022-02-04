# frozen_string_literal: true

# Service for Update
# examples:
# - Events::Services::Update.new(events, {}).call

module Events
  module Services
    # Implement Update
    class Update
      attr_reader :event

      def initialize(event, options = {})
        @event = event
        @options = options
      end

      def call
        @event.update(@options).tap do |_|
          @event.tag_list.add(find_tags_in_description)
          @event.save
        end
      end

      private

      def find_tags_in_description
        Tags::Queries::SearchByTags.new(@event.description, ActsAsTaggableOn::Tag.all).call
      end
    end
  end
end
