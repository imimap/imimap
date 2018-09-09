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

def geocoded_address(company:)
  result = nil
  while result.nil?
    result = Geocoder.search("#{rand(-80..80) + rand}, #{rand(-180..180) + rand}").first
    result = nil unless result.data['error'].nil?
  end
  CompanyAddress.create!(
    company: company,
    street: result.street || result.village,
    zip: result.postal_code,
    city: result.city || result.state,
    country: result.country,
    phone: Faker::PhoneNumber.phone_number
  )
end
