FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    user factory: :user
    description { Faker::Lorem.paragraph }
    phone { Faker::PhoneNumber.phone_number }
  end
end
