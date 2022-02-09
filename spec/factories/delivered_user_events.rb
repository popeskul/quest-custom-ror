# frozen_string_literal: true

FactoryBot.define do
  factory :delivered_tag_subscription do
    email { Faker::Internet.email }
    association :tag_subscription_id, factory: :tag_subscription
    event_ids { create_list(:event, 2).map(&:id) }
  end
end
