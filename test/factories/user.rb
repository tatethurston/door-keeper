FactoryBot.define do
  factory :user do
    association :organization
    name { "Test User" }
    email { "test.user@gmail.com" }
    image { "https://lh3.googleusercontent.com/a-/AAuE7mAweNtDFT4t1EvRM9ZB_mriuBNBddGH4F5xk8AR" }
  end
end
