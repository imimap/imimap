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

def create_company_address_with(result:, country_code:, company:)
  CompanyAddress.create!(
    company: company,
    street: result.street || result.village,
    zip: result.postal_code,
    city: result.city || result.state,
    country: country_code,
    phone: Faker::PhoneNumber.phone_number
  )
end

def country_code(geocoder_result:)
  if geocoder_result.country_code
    geocoder_result.country_code.upcase
  else
    'UK'
  end
end

def find_random_address
  result = nil
  while result.nil?
    result = Geocoder
             .search("#{rand(-80..80) + rand}, #{rand(-180..180) + rand}")
             .first
    if result.data.nil?
      # probably no network connection
      puts 'could not geocode address'
      return nil
    end
    result = nil unless result.data['error'].nil?
  end
  result
end

def geocoded_address(company:)
  random_address = find_random_address
  create_company_address_with(result: random_address,
                              country_code: country_code(
                                geocoder_result: random_address
                              ),
                              company: company)
end
