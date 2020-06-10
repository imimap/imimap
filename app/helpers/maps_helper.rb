# frozen_string_literal: true

# Helper Methods for Maps Views
module MapsHelper
  def company_locations_json(company_locations:)
    companies = company_locations.reject { |c| c.include?(nil) }
    company_location_json_raw = companies_to_array(companies)
    company_location_json_raw.to_json.html_safe
  end

  def internships_json(internships:, all_semester: false)
    internships = internships.reject { |c| c.include?(nil) }
    internships = internships_to_array(internships, all_semester)
    internships.to_json.html_safe
  end

  private

  def companies_to_array(companies)
    companies = companies.map do |c|
      text = "#{c[0]}, #{c[1]}".tr('\'', ' ')
      [text, c[2] + rand(-1.0..1.0), c[3] + rand(-1.0..1.0)]
    end
    companies.uniq { |c| c[0] }
  end

  def internships_to_array(internships, all_semester)
    internships.map do |c|
      [internship_text(c, all_semester),
       c[5], c[6]]
    end
  end

  def internship_text(companies, all_semester)
    c = companies
    first_line = "#{c[0]} #{c[1]} @ #{c[2]}"
    second_line = "in #{c[3]} #{c[4]}"
    second_line += ", #{c[7]}" if all_semester
    "#{first_line}<br />#{second_line}".tr('\'', ' ')
  end
end
