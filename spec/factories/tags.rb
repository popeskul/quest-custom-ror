# frozen_string_literal: true

FactoryBot.define do
  factory :tag, class: ActsAsTaggableOn::Tag do
    name { Faker::Finance.stock_market }

    trait :invalid do
      name { nil }
    end
  end
end
