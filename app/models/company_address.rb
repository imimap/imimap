class CompanyAddress < ApplicationRecord
    belongs_to :company
    has_many :internships
    validates_presence_of :company

    def one_line
      [street, zip, city, country].compact.join(', ')
    end
end
