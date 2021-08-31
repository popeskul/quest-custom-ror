class Event < ApplicationRecord
  validates :title, presence: true
  validates :location, presence: true
  validates :organizeremail, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'invalid email' }

  validates :starttime, :endtime, presence: true, correct_dates: true

  paginates_per 10
end
