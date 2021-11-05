# frozen_string_literal: true

# SearchByTags service
module Services
  # implement SearchByTags Services
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
      total_tags = []

      @tags.filter do |tag|
        tag.keys&.split(',')&.each do |key|
          total_tags << tag if @text.include?(key)
        end
      end

      total_tags
    end
  end
end
