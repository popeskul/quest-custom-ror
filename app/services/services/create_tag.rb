# frozen_string_literal: true

# Service for CreateTag
module Services
  # Implement CreateTag
  class CreateTag
    attr_reader :tag

    def initialize(options = {})
      @tag = ActsAsTaggableOn::Tag.new(options)
    end

    def call
      @tag.save
      @tag
    end
  end
end
