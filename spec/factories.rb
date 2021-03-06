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

  factory :invoice do
    association :merchant
    status { Faker::Name.name}
  end

  factory :customer do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
  end
end
