FactoryGirl.define do
  factory :todo do
    title { Faker::Lorem.word }
    complete false
    user nil
  end
end
