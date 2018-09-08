# frozen_string_literal: true

# Helper Methods for Maps Views
module MapsHelper
  def company_locations_json(company_addresses:)
    companies = company_addresses.pluck(:city, :country, :latitude, :longitude)
    companies = companies.reject { |c| c.include?(nil) }
    companies = companies.map { |c| ["#{c[0]}, #{c[1]}", c[2], c[3]] }
    company_location_json_raw = companies.uniq { |c| c[0] }
    company_location_json_raw.each do |x|
      x[0] = x[0].tr('\'', ' ')
    end
    company_location_json_raw << ['HTW, Berlin', 52.4569311, 13.5242551]
    company_location_json_raw.to_json.html_safe
  end
end
