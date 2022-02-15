# frozen_string_literal: true

FactoryBot.define do
  factory :tag_subscription do
    email { Faker::Internet.email }
    tags { %w[ruby backend] }

    trait :invalid_tags do
      tags { nil }
    end

    trait :invalid_email do
      email { nil }
    end
  end
end
