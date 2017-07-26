Student.destroy_all
10.times do
  Student.create!(
    import_id: Faker::Number.number(1),
    enrolment_number: Faker::Number.number(10),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    birthday: Faker::Date.birthday(18, 65),
    birthplace: Faker::Address.country
  )
end