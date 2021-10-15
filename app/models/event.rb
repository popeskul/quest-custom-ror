# frozen_string_literal: true

class Event < ApplicationRecord
  include AASM

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :title, presence: true
  validates :location, presence: true
  validates :organizer_email, format: { with: URI::MailTo::EMAIL_REGEXP, message: I18n.t('.invalid_email') }

  validates :start_time, :end_time, presence: true, correct_dates: true

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
end
