# frozen_string_literal: true

FactoryBot.define do
    factory :user do
        email { Faker::Internet.email }
        username { Faker::Name.name[4..18]}
        bio { Faker::Name.name }
        password { Faker::Internet.password }
        password_confirmation { password }
    end

    trait :with_avatar do
        avatar { create(:avatar, :with_user) }
    end
end