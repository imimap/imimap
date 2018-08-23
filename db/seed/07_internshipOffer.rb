# frozen_string_literal: true

10.times do
  InternshipOffer.create!(
    title: "#{Faker::Job.title}, #{Faker::Job.field}",
    body: Faker::Lorem.paragraph(2, false, 4)
  )
end
