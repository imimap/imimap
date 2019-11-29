# frozen_string_literal: true

# Helper Methods for Internship stuff
module InternshipsHelper
  def student_name(internship:)
    internship.student.name
  end
end
