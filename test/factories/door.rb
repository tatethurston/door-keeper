FactoryBot.define do
  factory :door do
    association :organization
    name { "Test Door" }
    phone_number { "+16505130122" }
    timezone { "America/Los_Angeles" }
  end
end
