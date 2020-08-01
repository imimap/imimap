# frozen_string_literal: true

def mockpath
  path_helpers = %i[complete_internships_path
                    new_complete_internship_path
                    edit_complete_internship_path
                    complete_internship_path]
  path_helpers.each do |path_helper|
    allow(view).to receive(path_helper)
      .and_return("mockpath/#{path_helper}")
  end
end
