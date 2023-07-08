FactoryBot.define do
  factory :card do
    customer factory: :customer
    company factory: :company
    name { Faker::Name.name }
    score { 0 }
    max_score { 100 }
    status { 0 }
    expires_at { 30.days.from_now }
  end
end
