# frozen_string_literal: true

FactoryBot.define do
  factory :semester do
    name { 'semester name' }
  end
  factory :ws2018, class: Semester do
    name { 'WS 2018/19' }
  end
  factory :ss2018, class: Semester do
    name { 'SS 2018' }
  end
end
