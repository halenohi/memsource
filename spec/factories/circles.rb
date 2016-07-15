FactoryGirl.define do
  factory :circle do
    sequence(:name) { |n| "sample#{n}" }
    sequence(:description) { |n| "sample test#{n}"}
    members_count 0
  end
end
