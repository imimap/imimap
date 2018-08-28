# frozen_string_literal: true

class CompanyAddress < ApplicationRecord
  belongs_to :company
  has_many :internships
  validates_presence_of :company

  def one_line
    [street, zip, city, country].compact.join(', ')
  end

  # TBD: put geocoding back in
  # geocoded_by :address
  # TBD: geocoding should only happen if necessary, see
  # https://github.com/alexreisner/geocoder#avoiding-unnecessary-api-requests
  # after_validation :geocode, if: :address_changed?
  # acts_as_gmappable :process_geocoding => false

  # def address_changed?
  # street_changed? || city_changed? || zip_changed? || country_changed?
  # end
end
