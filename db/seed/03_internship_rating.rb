# frozen_string_literal: true

InternshipRating.destroy_all
5.times do
  InternshipRating.create!(
    appreciation: Faker::Number.between(from: 0, to: 5),
    atmosphere: Faker::Number.between(from: 0, to: 5),
    supervision: Faker::Number.between(from: 0, to: 5),
    tasks: Faker::Number.between(from: 0, to: 5),
    training_success: Faker::Number.between(from: 0, to: 5)
  )
end
