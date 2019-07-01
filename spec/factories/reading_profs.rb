# frozen_string_literal: true

FactoryBot.define do
  factory :reading_prof do
    name { 'reading prof name' }
  end

  factory :reading_prof1, class: ReadingProf do
    name { 'Prof. 1' }
  end

  factory :reading_prof2, class: ReadingProf do
    name { 'Prof. 2' }
  end

  factory :reading_prof3, class: ReadingProf do
    name { 'Prof. 3' }
  end
end
