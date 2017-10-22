module MapHelper
  def company_locations_json
    companies = Company.pluck(:city, :country, :latitude, :longitude)
    companies = companies.reject { |c| c.include?(nil) }
    companies = companies.map { |c| ["#{c[0]}, #{c[1]}", c[2], c[3]] }
    company_location_json_raw = companies.uniq { |c| c[0] }
    company_location_json_raw.each do |x|
      x[0] = x[0].tr('\'', ' ')
    end
    company_location_json_raw.to_json.html_safe
  end
end
