# frozen_string_literal: true

# maybe CompleteInternshipData moves here.
module CompleteInternshipsHelper
  def semester_select_options
    Semester.all.map { |s| [s.name, s.id] }
  end
end
