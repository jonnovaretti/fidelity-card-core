FactoryBot.define do
  factory :card do
    customer factory: :customer
    company factory: :company
    name { Faker::Name.name }
    score { 0 }
    status { 0 }
    expires_at { nil }
  end
end
