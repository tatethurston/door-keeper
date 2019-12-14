FactoryBot.define do
  factory :code do
    association :organization
    name { "Test Code" }
    value { "1234" }

    trait :disabled do
      disabled_at { Time.now }
    end

    trait :anytime do
      allowed_time { nil }
    end
  end
end
