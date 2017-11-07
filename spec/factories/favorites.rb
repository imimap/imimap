# frozen_string_literal: true

#
FactoryGirl.define do
  factory :favorite do
    user
    internship
    comparebox false
  end
end
