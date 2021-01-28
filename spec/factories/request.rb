# frozen_string_literal: true

FactoryBot.define do
  factory :request do
    association :freelancer, factory: :freelancer
  end
end
