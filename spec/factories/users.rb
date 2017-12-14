FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone { Faker::Number.number(10) }
    password 'longpassword'
    password_confirmation 'longpassword'
    license_plate { Faker::Vehicle.vin }
    association :type
  end

  factory :invalid_user, parent: :user do
    email nil
    first_name nil
    last_name nil
    phone nil
    password nil
    password_confirmation nil
    gopay -10
  end                                                                                                                                                                               
end