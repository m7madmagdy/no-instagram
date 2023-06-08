# frozen_string_literal: true

FactoryBot.define do
    factory :post do
        title { Faker::Lorem.paragraph }  
        description { Faker::Lorem.paragraph }
        keywords { Faker::Lorem.paragraph }  
    end
  
    trait :with_user do
      user { create(:user) }
    end
  end