FactoryBot.define do
  factory :user do
    email { "test_user@test.com" }
    password { "password" }
    api_key { "12345678901234567890" }
  end
end
