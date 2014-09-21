FactoryGirl.define do
  factory :publisher, class: Trac::Publisher do
    sequence(:publisher_name) { |n| "Publisher#{n}" }
  end

  factory :advertiser, class: Trac::Advertiser do
    sequence(:advertiser_name) { |n| "Advertiser#{n}" }
  end

  factory :offer, class: Trac::Offer do
    sequence(:offer_name) { |n| "Offer#{n}" }
    expires_on Date.today + 1.day
  end

  factory :product, class: Trac::Product do
    sequence(:product_name) { |n| "Product#{n}" }
  end


  factory :offer_with_advertiser, class: Trac::Offer do
    advertiser
    product

    sequence(:offer_name) { |n| "Offer X#{n}" }
    expires_on Date.today + 1.day
  end
end
