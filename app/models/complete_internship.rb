class CompleteInternship < ApplicationRecord
  belongs_to :student
  has_many :internships
end
