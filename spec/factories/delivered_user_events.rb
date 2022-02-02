# frozen_string_literal: true

FactoryBot.define do
  factory :delivered_user_event do
    association :user, factory: :user
    association :event, factory: :event
  end
end
