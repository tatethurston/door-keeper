FactoryBot.define do
  factory :access_log do
    association :code
    association :door
  end
end
