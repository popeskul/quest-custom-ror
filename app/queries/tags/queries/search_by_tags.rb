# frozen_string_literal: true

# SearchByTags service
# examples:
# - Tags::Queries::SearchByTags.new('Some long text', tags).call
# results: [], [Tag, Tag, ...]

module Tags
  module Queries
    # implement SearchByTags
    class SearchByTags
      attr_reader :tags

      def initialize(text, tags)
        @text = text.strip
        @tags = tags
      end

      def call
        return [] if @tags.empty? || @text.empty?

        found_tags_by_keys
      end

      private

      def found_tags_by_keys
        @tags.each_with_object([]) do |tag, total_tags|
          split_keys = tag.keys&.split(',')
          split_keys&.each { |key| total_tags << tag if @text.include?(key) }
        end
      end
    end
  end
end
