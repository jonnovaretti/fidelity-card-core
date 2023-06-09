FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.phone_number }
    company factory: :company
  end
end
