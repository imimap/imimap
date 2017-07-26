ReadingProf.destroy_all
10.times do
  ReadingProf.create!(
    name: Faker::Name.last_name
  )
end