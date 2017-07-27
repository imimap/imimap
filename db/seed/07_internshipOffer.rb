# ruby encoding: utf-8
10.times do
  InternshipOffer.create!(
    title: Faker::Job.title,
    body: Faker::ChuckNorris.fact
  )
end