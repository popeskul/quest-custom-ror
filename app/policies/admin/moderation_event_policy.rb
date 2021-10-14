# frozen_string_literal: true

# PendingEvent policy
module Admin
  # ModerationEvent policy
  class ModerationEventPolicy < ApplicationPolicy
    def index?
      admin? if user_present?
    end

    def approve?
      admin? if user_present?
    end

    def decline?
      admin? if user_present?
    end
  end
end
