# frozen_string_literal: true

class DeliveredUserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  scope :delivered_by, ->(event_id:, user_id:) { where(event_id: event_id, user_id: user_id).uniq }
end
