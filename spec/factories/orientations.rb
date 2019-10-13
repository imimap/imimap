# frozen_string_literal: true

FactoryBot.define do
  factory :orientation do
    name { 'Web Development name' }
  end
  factory :orientation1, class: Orientation do
    name { 'Games' }
  end
  factory :orientation2, class: Orientation do
    name { 'Test Automation' }
  end
end
