FactoryBot.define do
    factory :review do
        comment { Faker::Restaurant.review }
        user
        restaurant

        trait :with_photo do
            photo {AttachedHelper.jpg}
        end
    end
end