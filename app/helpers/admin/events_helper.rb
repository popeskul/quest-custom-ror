# frozen_string_literal: true

# Admin namespace for TagsHelper
module Admin
  # implement Tags helper
  module EventsHelper
    def all_tags
      ActsAsTaggableOn::Tag.all
    end
  end
end
