FactoryGirl.define do
  factory :order do
    sequence :external_id do |n|
      n
    end    
    origin "Kolla Space Sabang"
    destination "Pasaraya Blok M"
    price 10000
    association :user
    association :type
  end
end