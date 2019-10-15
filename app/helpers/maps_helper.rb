# frozen_string_literal: true

# Helper Methods for Maps Views
module MapsHelper
  include ActionView::Helpers::UrlHelper
  def company_locations_json(company_locations:)
    companies = company_locations.reject { |c| c.include?(nil) }
    companies = companies.map do |c|
      text = "#{c[0]}, #{c[1]}".tr('\'', ' ')
      [text, c[2] + rand(-1.0..1.0), c[3] + rand(-1.0..1.0)]
    end
    company_location_json_raw = companies.uniq { |c| c[0] }
    company_location_json_raw.to_json.html_safe
  end

  def internships_json(internships:, all_semester: false)
    internships = internships.reject { |c| c.include?(nil) }

    internships = internships.map do |c|
      first_line = "#{c[0]} #{c[1]} @ #{c[2]}"
      second_line = "in #{c[3]} #{c[4]}"
      second_line += ", #{c[7]}" if all_semester
      text = "#{first_line}<br />#{second_line}".tr('\'', ' ')
      [text,
       c[5], c[6]]
    end
    # internships << ['HTW Berlin', 52.4569311, 13.5242551]
    internships.to_json.html_safe
  end
end
