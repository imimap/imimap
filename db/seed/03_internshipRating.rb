# frozen_string_literal: true

InternshipRating.destroy_all
5.times do
  InternshipRating.create!(
    appreciation: Faker::Number.between(0, 5),
    atmosphere: Faker::Number.between(0, 5),
    supervision: Faker::Number.between(0, 5),
    tasks: Faker::Number.between(0, 5),
    training_success: Faker::Number.between(0, 5)
  )
end
