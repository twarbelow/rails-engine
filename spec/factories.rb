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

  factory :invoice_item do
    association :item
    association :invoice
    quantity { rand(100) }
    unit_price { rand(1.11..99.99).round(2) }
  end

  factory :transaction do
    association :invoice
    credit_card_number { Faker::Finance.credit_card }
    credit_card_expiration_date { Faker::Date.forward(days: 100) }
    result { ['refunded', 'success', 'failed'].sample }
  end

end
