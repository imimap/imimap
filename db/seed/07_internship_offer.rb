# frozen_string_literal: true

10.times do
  InternshipOffer.create!(
    title: "#{Faker::Job.title}, #{Faker::Job.field}",
    body: Faker::Lorem.paragraph(sentence_count: 2,
                                 supplemental: false,
                                 random_sentences_to_add: 4),
    active: rand(2).zero?,
    city: Faker::Address.city,
    country: Faker::Address.country
  )
end
