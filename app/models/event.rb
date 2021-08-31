class Event < ApplicationRecord
  validates :title, presence: true
  validates :location, presence: true
  validates :organizeremail, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'invalid email' }

  validates :starttime, presence: true
  validates :endtime, presence: true

  validate do
    if self.starttime && self.endtime
      self.errors[:start] << 'must be a valid date' if self.starttime > self.endtime
    end
  end

  paginates_per 10
end
