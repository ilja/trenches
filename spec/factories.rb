FactoryGirl.define do
  factory :project do
    name 'my project'
  end

  factory :sprint do
    start_date Time.now - 2.weeks
    end_date Time.now + 2.weeks
    name 'my sprint'
  end

  factory :story do
    name 'my story'
  end

  factory :user do
    name 'user'
  end
end
