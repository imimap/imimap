Orientation.destroy_all
10.times do
  Orientation.create!(
    name: Faker::Job.field,
    id: Faker::Number.number(1)
  )
end