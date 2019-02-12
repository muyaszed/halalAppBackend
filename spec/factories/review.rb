FactoryBot.define do
    factory :review do
        comment { Faker::Restaurant.review }
        user_id nil
        restaurant
    end
end