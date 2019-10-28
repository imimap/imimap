# frozen_string_literal: true

FactoryBot.define do
  factory :user_can_see_company do
    company
    user
    created_by { 1 }
  end
end
