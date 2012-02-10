FactoryGirl.define do
  factory :project do

  end

  factory :user do
    email
    sequence(:password) {|n| "secret#{n}" }
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end
end
