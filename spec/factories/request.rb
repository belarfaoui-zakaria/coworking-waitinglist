# frozen_string_literal: true

FactoryBot.define do
  factory :request do
    association :freelancer, factory: :freelancer
    trait :unconfirmed do
      state { :unconfirmed }
    end

    trait :expired do
      state { :confirmed }
      will_expire_at { DateTime.now }
    end
  end
end
