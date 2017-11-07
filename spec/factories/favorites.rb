# frozen_string_literal: true

#
FactoryBot.define do
  factory :favorite do
    user
    internship
    comparebox false
  end
end
