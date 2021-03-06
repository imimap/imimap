# frozen_string_literal: true

# Helper for Students Views
module StudentsHelper
  def student_selector(student:)
    s = student
    "#{s.enrolment_number}, #{s.last_name}, #{s.first_name}"
  end
end
