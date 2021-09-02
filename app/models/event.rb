# frozen_string_literal: true

class Event < ApplicationRecord
  validates :title, presence: true
  validates :location, presence: true
  validates :organizer_email, format: { with: URI::MailTo::EMAIL_REGEXP, message: I18n.t('.invalid_email') }

  validates :start_time, :end_time, presence: true, correct_dates: true

  paginates_per 10
end
