# frozen_string_literal: true

# "CompleteInternship" respresents the course B20 for one student.
# It holds general information as "AEP passed" as well as a collection
# of all the concrete Internships in concrete companies as the whole
# internship course B20 may be divided into up to 3 partial internships.
class CompleteInternship < ApplicationRecord
  belongs_to :student
  has_many :internships
end
