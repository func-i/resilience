# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :building_block do
    title "MyString"
    owner factory: :user
  end
end
