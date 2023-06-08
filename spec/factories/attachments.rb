# frozen_string_literal: true

FactoryBot.define do
    factory :attachment do
      resource_id { Random.hex(2) }
      resource_type { 'image/png' }
      resource_url { 
        "https://i.imgur.com/#{resource_id}.png"
       }
       raw_response { Faker::Lorem.paragraph }
    end
  
    trait :with_post do
      post { create(:post, :with_user) }
    end
  end
  