FactoryGirl.define do
  factory :type do
    sequence :name do |n|
      "type#{n}"
    end
    base_fare 1500
  end

  factory :invalid_type, parent: :type do
    type nil
    base_fare nil
  end
end
