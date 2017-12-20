FactoryGirl.define do
  factory :type do
    sequence :name do |n|
      "type#{n}"
    end
  end

  factory :invalid_type, parent: :type do
    type nil
  end
end
