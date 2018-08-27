class CompanyAddress < ApplicationRecord
    belongs_to :company
    has_many :internships
    validates_presence_of :company
end
