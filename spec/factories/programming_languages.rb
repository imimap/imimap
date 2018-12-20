# frozen_string_literal: true

FactoryBot.define do
  factory :programming_language do
    name { 'programming language name' }
  end
  factory :forth, class: ProgrammingLanguage do
    name { 'Forth' }
  end
  factory :whitespace, class: ProgrammingLanguage do
    name { 'Whitespace' }
  end
  factory :velato, class: ProgrammingLanguage do
    name { 'Velato' }
  end
  factory :omgrofl, class: ProgrammingLanguage do
    name { 'OMG!1!1 Rofl!!1!' }
  end
  factory :piet, class: ProgrammingLanguage do
    name { 'Piet' }
  end
  factory :brainfuck, class: ProgrammingLanguage do
    name { 'Brainfuck' }
  end
end
