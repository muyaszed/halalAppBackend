FactoryBot.define do
    factory :restaurant do
        name { Faker::Restaurant.name }
        address { Faker::Address.street_address}
        city {Faker::Address.city}
        postcode {Faker::Address.postcode}
        country {Faker::Address.country}
        category { Faker::Restaurant.name }
        cuisine { Faker::Restaurant.type }
        desc { Faker::Restaurant.description }
        latitude {Faker::Address.latitude}
        longitude {Faker::Address.longitude}
        start {'8:00'}
        add_attribute(:end) {'17:00'}
        web  {'http://example.com'}
        user

        trait :with_cover do
            cover {AttachedHelper.jpg}
        end

        
    end
end