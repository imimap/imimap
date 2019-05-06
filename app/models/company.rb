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

  def input_name
    @company.try(:name)
  end

  def input_name=(name)
    self.name = Company.find_or_create_by(name: name) if name.present?
  end
end
