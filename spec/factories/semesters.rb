# frozen_string_literal: true

FactoryBot.define do
  factory :semester do
    name { 'WS 11/12' }
  end
  factory :ws2018, class: Semester do
    name { 'WS 18/19' }
  end
  factory :ss2018, class: Semester do
    name { 'SS 18' }
  end
end
