# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { Faker::Internet.email }
    password 'fakepassword'
    name { Faker::Name.name}
    organization { Faker::Company.name }
    phone { Faker::PhoneNumber.phone_number }
  end
end
