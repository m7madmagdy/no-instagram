# frozen_string_literal: true

FactoryBot.define do
    factory :avatar do
      avatar_id { Random.hex(2) }
      avatar_type { 'image/png' }
      avatar_url { 
        "https://i.imgur.com/#{avatar_id}.png"
       }
       raw_response { Faker::Lorem.paragraph }
    end
end
  