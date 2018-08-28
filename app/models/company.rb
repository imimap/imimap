# frozen_string_literal: true

# The Company where an Internship takes place.
class Company < ApplicationRecord
  validates :name, presence: true, allow_blank: false
  has_many :company_addresses
  has_many :internships, through: :company_addresses

  # TBD: rename
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

  # TBD ST: needs refactoring - what does it do?
  # it produces a list for a company selection box in the view.
  # this and the map that follows in the view should be moved to a helper
  # method.
  def self.company_name_address
    i = 0
    a = []
    Company.all.each do |c|
      j = 0
      c.company_addresses.each do |c_a|
        a[i] = []
        a[i] << c_a.id
        a[i] << "#{c.name}, #{c_a.street}"
        i += 1
      end
    end
    a
  end

  def company_name
    try(:name)
  end

  def company_name=(name)
    self.company = Company.find_or_create_by_name(name) if name.present?
  end
end
