FactoryBot.define do
  factory :event do
    sequence(:title)             { |n| "Title #{n}" }
    sequence(:description)       { |n| "Description #{n}" }
    sequence(:location)          { |n| "location #{n}" }
    sequence(:organizeremail)    { |n| "email#{n}@mail.com" }
    sequence(:organizertelegram) { |n| "email#{n}@mail.com" }
    sequence(:link)              { |n| "link#{n}" }
    sequence(:starttime)         { |n| DateTime.new(2000 + n, 10, 1) }
    sequence(:endtime)           { |n| DateTime.new(2000 + (n + 1), 10, 1) }
  end

  trait :invalid_dates do
    sequence(:starttime)         { |n| DateTime.new(2000 + (n + 1), 10, 1) }
    sequence(:endtime)           { |n| DateTime.new(2000 + n, 10, 1) }
  end
end
