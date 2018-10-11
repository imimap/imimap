# frozen_string_literal: true

# Composes all Internship Information in one Class to pass to the view
module CompleteInternshipHelper
  def CompleteInternship.from(int)
    ci = CompleteInternship.new
    ci.add_student_info(int)
    ci.add_company_info(int)
    ci.add_status_info(int)
    ci
  end

  def CompleteInternship.to_csv(complete_internships)
    CSV.generate do |csv|
      csv << COMPLETE_INTERNSHIP_MEMBERS
      complete_internships.each do |ci|
        csv << ci.to_a
      end
    end
  end
end
