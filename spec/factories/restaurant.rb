FactoryBot.define do
    factory :restaurant do
        name { Faker::Restaurant.name }
        location { Faker::WorldCup.city}
        category { Faker::Restaurant.name }
        user

        
    end
end