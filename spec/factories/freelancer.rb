# frozen_string_literal: true

FactoryBot.define do
  factory :freelancer do
    biography { 'I am a freelancer' }
    name { 'John Doe' }
    phone_number { '0662802299' }
    email { 'example@gmail.com' }
  end
end
