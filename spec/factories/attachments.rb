# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    title ""
    attachable nil
    file File.new("#{Rails.root}/spec/fixtures/files/user_photo.jpg")
  end
end
