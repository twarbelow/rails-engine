FactoryBot.define do
  factory :merchant do
    name { Faker::Name.name }
  end

  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Marketing.buzzwords }
    unit_price { Faker::Commerce.price }
    association :merchant
  end
end
