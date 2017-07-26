Company.destroy_all
10.times do
  Company.create!(
    street: Faker::Address.street_address,
    zip: Faker::Address.zip,
    name: Faker::Company.name,
    number_employees: Faker::Number.number(3),
    city: Faker::Address.city,
    country: Faker::Address.country,
    phone: Faker::PhoneNumber.phone_number,
    blacklisted: Faker::Boolean.boolean,
    import_id: Faker::Number.number(1),
    website: Faker::Internet.url('example.com')
  )
end