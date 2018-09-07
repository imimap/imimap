# frozen_string_literal: true

# One of possibly many Addresses for a Company.
# One Internship has one CompanyAddress.
class CompanyAddress < ApplicationRecord
  belongs_to :company
  has_many :internships
  validates_presence_of :company

  def one_line
    [street, zip, city, country].compact.join(', ')
  end

  def address
    "#{street}, #{zip} #{city}, #{country}"
  end

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # TBD: geocoding should only happen if necessary, see
  # https://github.com/alexreisner/geocoder#avoiding-unnecessary-api-requests

  # acts_as_gmappable :process_geocoding => false

  def address_changed?
    street_changed? || city_changed? || zip_changed? || country_changed?
  end
end
