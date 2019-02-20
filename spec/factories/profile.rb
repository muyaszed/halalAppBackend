FactoryBot.define do
    factory :profile do
        avatar { Faker::Avatar.image }
        user
    end
end