# frozen_string_literal: true

# One of possibly many Addresses for a Company.
# One Internship has one CompanyAddress.
class CompanyAddress < ApplicationRecord
  belongs_to :company
  has_many :internships
  validates :street, :country, :city, presence: true
  validates_presence_of :company


  def self.fields_required_for_application
    [:start_date, :end_date, :semester, :title]
  end
  # move to ApplicationRecord
  def self.required_for_application?(field_name)
    fields_required_for_application.includes?
  end

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

  def all_company_address_details_filled?
    !(street.blank? || zip.blank? || city.blank? || country.blank?)
  end
end
