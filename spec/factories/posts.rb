FactoryBot.define do
  factory :post do
    user
    message { Faker::Lorem.sentence }
    published { true }
  end
end
