# frozen_string_literal: true

# model TagSubscription
class TagSubscription < ApplicationRecord
  has_many :delivered_tag_subscriptions, foreign_key: :tag_subscription_id, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :tags, exclusion: { in: [nil], message: I18n.t('error.blank') }

  scope :find_tags, ->(tags) { ActsAsTaggableOn::Tag.where(name: tags) }
end
