# frozen_string_literal: true

# "CompleteInternship" respresents the course B20 for one student.
# It holds general information as "AEP passed" as well as a collection
# of all the concrete Internships in concrete companies as the whole
# internship course B20 may be divided into up to 3 partial internships.
class CompleteInternship < ApplicationRecord
  belongs_to :student # , class_name: 'Student', foreign_key: :student_id
  belongs_to :semester
  has_many :internships
  has_many :internships_new,
           class_name: 'Internship',
           foreign_key: :complete_internship_id
  validates :student_id, :semester_id, :aep, :passed, presence: true

end
