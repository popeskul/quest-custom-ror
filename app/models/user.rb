# frozen_string_literal: true

# model User
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, as: :event_postable, foreign_key: 'event_postable_id', dependent: :destroy
  has_many :tag_subscriptions, foreign_key: :user_id, dependent: :destroy
end
