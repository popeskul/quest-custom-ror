# frozen_string_literal: true

# Admin namespace for TagsHelper
module Admin
  # implement Tags helper
  module TagsHelper
    def new_tag
      ActsAsTaggableOn::Tag.new
    end

    def find_tag(options)
      ActsAsTaggableOn::Tag.find(options)
    end
  end
end
