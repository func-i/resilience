# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :regular_role, class: Role do
    name 'regular'
  end

  factory :administrator_role, class: Role do
    name 'administrator'
  end
end
