# frozen_string_literal: true

# Service CreateTag
# examples:
# - Tags::Services::CreateTag.new(name: 'backend', keys: 'ruby, python').call

module Tags
  module Services
    # Implement CreateTag
    class CreateTag
      attr_reader :tag

      def initialize(options = {})
        @tag = ActsAsTaggableOn::Tag.new(options)
      end

      def call
        @tag.tap(&:save)
      end
    end
  end
end
