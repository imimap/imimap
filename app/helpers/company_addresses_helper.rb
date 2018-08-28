# frozen_string_literal: true

module CompanyAddressesHelper
  def company_address_selector(company_address:)
    name = company_address.company.name
    street = company_address.street
    city = company_address.city
    country = company_address.country
    "#{name}, #{street}, #{city}, #{country}"
  end
end
