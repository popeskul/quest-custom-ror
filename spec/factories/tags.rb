# frozen_string_literal: true

FactoryBot.define do
  factory :tag, class: ActsAsTaggableOn::Tag do
    sequence(:name) { |n| "#{Faker::Finance.stock_market}-#{n}" }

    trait :invalid do
      name { nil }
    end
  end
end
