# frozen_string_literal: true

# "CompleteInternship" respresents the course B20 for one student.
# It holds general information as "AEP passed" as well as a collection
# of all the concrete Internships in concrete companies as the whole
# internship course B20 may be divided into up to 3 partial internships.
class CompleteInternship < ApplicationRecord
  belongs_to :student
  belongs_to :semester
  has_many :internships
  has_many :internships_new,
           class_name: 'Internship',
           foreign_key: :complete_internship_id
  validates :student, presence: true

  def over?
    # sum of the durations of every parcial internship of they are over already
    week_count = Internship.where('complete_internship_id = ? AND end_date < ?',
                                  id, Date.today)
                           .map { |tp| tp.duration.weeks }
                           .sum
    week_count >= 16 # not beautiful because of hardcoded duration
  end
end
