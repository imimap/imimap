# frozen_string_literal: true

FactoryBot.define do
  factory :internship_state do
    name { 'passed' }
    name_de { 'bestanden' }
  end
  factory :internship_state_passed, class: InternshipState do
    name { 'passed' }
    name_de { 'bestanden' }
  end
  factory :internship_state_aep, class: InternshipState do
    name { 'waiting for AEP' }
    name_de { 'wartet auf AEP' }
  end
end
