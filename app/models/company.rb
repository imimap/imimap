# frozen_string_literal: true

# The Company where an Internship takes place.
class Company < ApplicationRecord
  attr_accessible :street, :city, :country, :zip, :main_language, :department,
                  :industry, :name, :number_employees, :website, :phone,
                  :blacklisted, :fax, :import_id, :latitude, :longitude

  # validates :street, presence: true, allow_blank: false
  # validates :zip, presence: true, allow_blank: false
  # validates :city, presence: true, allow_blank: false
  # validates :country, presence: true, allow_blank: false
  # #validates :main_language, presence: true, allow_blank: false
  # #validates :industry, presence: true, allow_blank: false
  validates :name, presence: true, allow_blank: false
  # #validates :number_employees, presence: true, allow_blank: false
  # #validates :website, presence: true, allow_blank: false

  geocoded_by :address
  # TBD: geocoding should only happen if necessary, see
  # https://github.com/alexreisner/geocoder#avoiding-unnecessary-api-requests
  after_validation :geocode, if: :address_changed?
  # acts_as_gmappable :process_geocoding => false

  # associations
  has_many :internships

  # CodeReviewSS17: delete?
  # accepts_nested_attributes_for :internships

  def address
    [street, zip, city, country].compact.join(', ')
  end

  def enrolment_number
    internships.map { |x| x.student.enrolment_number }.join(', ')
  end

  def average_rating
    r = 0
    size = 0
    internships.select(&:completed).each do |x|
      if x.internship_rating.total_rating
        r += x.internship_rating.total_rating
        size += 1
      end
    end
    size ||= 1
    r.to_f / size
  end

  def address_changed?
    street_changed? || city_changed? || zip_changed? || country_changed?
  end
end
