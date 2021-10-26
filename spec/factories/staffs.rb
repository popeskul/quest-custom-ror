# frozen_string_literal: true

FactoryBot.define do
  factory :staff do
    email { Faker::Internet.email }
    password { '123123' }
    password_confirmation { '123123' }

    trait :admin do
      role { 'admin' }
    end

    trait :super_admin do
      role { 'super_admin' }
    end

    trait :invalid_role do
      role { 'invalid' }
    end

    trait :invalid_email do
      email { '123' }
    end
  end
end
