# frozen_string_literal: true

# Event model
class Event < ApplicationRecord
  include AASM

  scope :for_moderation, -> { where.not(aasm_state: 'approve') }

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :title, presence: true
  validates :location, presence: true
  validates :organizer_email, format: { with: URI::MailTo::EMAIL_REGEXP, message: I18n.t('.invalid_email') }

  validates :start_time, :end_time, presence: true, correct_dates: true

  after_create :send_email

  paginates_per 10

  aasm do
    state :pending, initial: true
    state :approved
    state :declined

    event :approve do
      transitions from: %i[pending declined], to: :approved
    end

    event :decline do
      transitions from: %i[approved pending], to: :declined
    end
  end

  private

  def send_email
    Services::CreatedEventNotification.call(self).deliver
  end
end
