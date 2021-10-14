# frozen_string_literal: true

# PendingEvent policy
module Admin
  # ModerationEvent policy
  class ModerationEventPolicy < ApplicationPolicy
    def index?
      admin?
    end

    def approve?
      admin?
    end

    def decline?
      admin?
    end
  end
end
