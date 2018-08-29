
# frozen_string_literal: true

module StudentsHelper
  def student_selector(student:)
    s = student
    "#{s.enrolment_number}, #{s.last_name}, #{s.first_name}"
  end

  def internships_list(student:)
    student.internships.join(', ')
  end
end
