# frozen_string_literal: true

# SearchByTags service
module Services
  # implement SearchByTags Services
  class SearchByTags
    attr_reader :tags

    def initialize(text, tags)
      @text = text
      @tags = tags
    end

    def call
      return [] if @tags.empty? || @text.empty?

      transformed_tags = tags.join('|')

      @text.scan(/\b#{transformed_tags}\b/i)
    end
  end
end
