# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { Faker::Internet.email }
    password 'fakepassword'
    name { Faker::Name.name}
    organization { Faker::Company.name }
    phone { Faker::PhoneNumber.phone_number }
    roles { build_list :regular_role, 1 }
  end

  factory :admin, parent: :user do
    roles { build_list :administrator_role, 1 }
  end
end
