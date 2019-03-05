# frozen_string_literal: true

ProgrammingLanguage.destroy_all
ProgrammingLanguage.where(name: 'Java').first_or_create
ProgrammingLanguage.where(name: 'C++').first_or_create
ProgrammingLanguage.where(name: 'C').first_or_create
ProgrammingLanguage.where(name: 'C#').first_or_create
ProgrammingLanguage.where(name: 'Ruby').first_or_create
ProgrammingLanguage.where(name: 'PHP').first_or_create
ProgrammingLanguage.where(name: 'Javascript').first_or_create
ProgrammingLanguage.where(name: 'HTML/CSS').first_or_create
ProgrammingLanguage.where(name: 'Python').first_or_create
