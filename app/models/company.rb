# frozen_string_literal: true

# The Company where an Internship takes place.
class Company < ApplicationRecord
  validates :name, presence: true, allow_blank: false
  has_many :company_addresses
  has_many :internships, through: :company_addresses

  def self.attributes_required_for_internship_application
    [:website]
  end

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
end

def company_suggestion(suggestion)
  # erste Runde, ungefaehres Matching
  first_search = '%' + suggestion + '%'
  results = Company.where('lower(name) LIKE ?', first_search)
  @case = if results.count.zero?
            3
          else
            1
          end
  if results.count > 4
    # zweite Runde, exaktes Matching
    results = Company.where('lower(name) LIKE ?', suggestion)
    @case = 1
    if results.count > 4
      @case = 2
      nil
    elsif results.count == 0
      @case = 2
      nil
    end
  end
  results
end
