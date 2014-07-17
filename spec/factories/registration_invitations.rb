# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registration_invitation do
    sender { FactoryGirl.create :regular_user }
    recipient_email { Faker::Internet.email }
    recipient nil
    state "new"
  end
end
