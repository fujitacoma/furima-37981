FactoryBot.define do
  factory :item do
    
    item_name	           { Faker::Name.name }
    content              { Faker::Lorem.sentence }
    category_id          { 2 }
    status_id            { 2 }
    delivery_charge_id   { 2 }
    prefecture_id        { 2 }
    sending_date_id      { 2 }
    price                { Faker::Number.between(from: 300, to: 999999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/test_image.png'), filename: 'test_image.png')
    end

  end
end
