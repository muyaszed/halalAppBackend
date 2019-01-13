FactoryBot.define do
    factory :restaurant do
        name { Faker::RockBand.name}
        location { Faker::WorldCup.city}
        category { Faker::Food.dish}
    end
end