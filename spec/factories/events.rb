# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :event do
    association :author, factory: :user
    title                              { Faker::Name.name }
    description                        { Faker::Lorem.sentence }
    location                           { Faker::Address.full_address }
    organizer_email                    { Faker::Internet.email }
    organizer_telegram                 { Faker::Internet.url }
    link                               { Faker::Internet.url }
    sequence(:start_time)        { |n| DateTime.new(2000 + n, 10, 1) }
    sequence(:end_time)          { |n| DateTime.new(2000 + (n + 1), 10, 1) }

    trait :invalid_dates do
      sequence(:start_time)        { |n| DateTime.new(2000 + (n + 1), 10, 1) }
      sequence(:end_time)          { |n| DateTime.new(2000 + n, 10, 1) }
    end

    factory :approved_event do
      aasm_state { 'approved' }
    end
  end
end
