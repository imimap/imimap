# frozen_string_literal: true

def faker_address(company:)
  CompanyAddress.create!(
    company: company,
    street: Faker::Address.street_address,
    zip: Faker::Address.zip,
    city: Faker::Address.city,
    country: Faker::Address.country,
    phone: Faker::PhoneNumber.phone_number
  )
end

def random_place_on_earth
  result = nil
  while result.nil?
    rl = Geocoder.search("#{rand(-80..80) + rand}, #{rand(-180..180) + rand}")
    result = rl.first
    result = nil unless result.data['error'].nil?
  end
  country_code = result.country_code ? result.country_code.upcase : 'GB'
  [result, country_code]
end

def geocoded_address(company:)
  location, country_code = random_place_on_earth

  CompanyAddress.create!(
    company: company,
    street: location.street || location.village,
    zip: location.postal_code,
    city: location.city || location.state,
    country: country_code,
    phone: Faker::PhoneNumber.phone_number
  )
end
