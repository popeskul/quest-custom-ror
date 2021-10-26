# frozen_string_literal: true

# model Event
class Staff < ApplicationRecord
  include AASM

  ROLES = %w[admin super_admin].freeze

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable

  has_many :events, as: :event_postable, foreign_key: :event_postable_id, dependent: :destroy

  scope :for_admin, -> { where(role: 'admin') }
  scope :for_super_admin, -> { where(role: 'super_admin') }

  paginates_per 10

  aasm column: :role do
    state :admin, initial: true
    state :super_admin

    event :change_to_admin do
      transitions from: :super_admin, to: :admin
    end

    event :change_to_super_admin do
      transitions from: :admin, to: :super_admin
    end
  end
end
