# frozen_string_literal: true

# Service for CreateStaff
module Services
  # Implement CreateStaff
  class CreateTag
    attr_reader :tag

    def initialize(options = {})
      @tag = ActsAsTaggableOn::Tag.new(options)
    end

    def call
      @tag
    end
  end
end
