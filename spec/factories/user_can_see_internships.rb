# frozen_string_literal: true

FactoryBot.define do
  factory :user_can_see_internship do
    internship
    user
  end
end
