# frozen_string_literal: true

# random
module GeocodedAddresses
  class NoConnectionError < StandardError
  end
  class NoConnectionError2 < StandardError
  end

  # generates random locations using random coordinates
  class Generator
    def find_random_address
      result = nil
      until geocoded?(result)
        result = random_spot
        raise NoConnectionError if result.nil?
        raise NoConnectionError2 if !result.data.nil? && result.data.nil?
      end
      result
    end

    def random_spot
      Geocoder.search("#{rand(-80..80) + rand}, #{rand(-180..180) + rand}")
              .first
    end

    def geocoded?(result)
      !result.nil? && result.data['error'].nil?
    end
  end

  # creates a CompanyAddress
  class CompanyAddressFactory
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

    def geocoded_company_address(company:)
      g = Generator.new
      random_address = g.find_random_address
      create_company_address_with(result: random_address,
                                  country_code: country_code(
                                    geocoder_result: random_address
                                  ),
                                  company: company)
    end

    def country_code(geocoder_result:)
      if geocoder_result.country_code
        geocoder_result.country_code.upcase
      else
        'UK'
      end
    end

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
  end
  def self.geocoded_company_address(company:)
    caf = CompanyAddressFactory.new
    caf.geocoded_company_address(company: company)
  rescue NoConnectionError
    puts 'no internet connection, seeding address without geocoding'
    faker_address(company: company)
  end
end
