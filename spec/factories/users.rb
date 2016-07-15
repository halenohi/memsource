FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "sample #{n}" }
    sequence(:email) { |n| "sample-#{n}@example.com" }
    password "samplepass"
  end
end
