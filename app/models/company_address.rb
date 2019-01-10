# frozen_string_literal: true

# One of possibly many Addresses for a Company.
# One Internship has one CompanyAddress.
class CompanyAddress < ApplicationRecord
  belongs_to :company
  has_many :internships
  validates_presence_of :company

  def one_line
    [street, zip, city, country_name].compact.join(', ')
  end

  def address(locale = I18n.locale)
    "#{street}, #{zip} #{city}, #{country_name(locale)}"
  end

  def address_en
    address(:en)
  end

  geocoded_by :address_en
  after_validation :geocode, if: :address_changed?

  # TBD: geocoding should only happen if necessary, see
  # https://github.com/alexreisner/geocoder#avoiding-unnecessary-api-requests

  # acts_as_gmappable :process_geocoding => false

  def address_changed?
    street_changed? || city_changed? || zip_changed? || country_changed?
  end

  # country is now a ISO3166-2 code. Use this method to get a
  # localized country name.
  def country_name(locale = I18n.locale)
    return nil unless country
    iso_country = ISO3166::Country[country]
    return country unless iso_country
    iso_country.translations[locale.to_s] || iso_country.name
  end

  # Get a list of all Countries available + number of entries per country
  scope :countries, -> { group(:country).count }

end
