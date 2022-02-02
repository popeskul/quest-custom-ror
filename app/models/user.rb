# frozen_string_literal: true

# model User
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, as: :event_postable, foreign_key: 'event_postable_id', dependent: :destroy
  has_many :delivered_user_events, foreign_key: :user_id, dependent: :destroy

  def self.generate_token
    SecureRandom.hex(10)
  end
end
