FactoryBot.define do
  factory :event do
    sequence(:title)             { |n| "Title #{n}" }
    sequence(:description)       { |n| "Description #{n}" }
    sequence(:location)          { |n| "location #{n}" }
    sequence(:organizeremail)    { |n| "email#{n}@mail.com" }
    sequence(:organizertelegram) { |n| "email#{n}@mail.com" }
    sequence(:link)              { |n| "link#{n}" }
    sequence(:starttime)         { |n| DateTime.new(2021, 10, n, 0, 0, 0) }
    sequence(:endtime)           { |n| DateTime.new(2021, 10, n + 1, 0, 0, 0) }
  end
end
