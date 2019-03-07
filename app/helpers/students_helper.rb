# frozen_string_literal: true

# Helper for Students Views
module StudentsHelper
  def student_selector(student:)
    s = student
    "#{s.enrolment_number}, #{s.last_name}, #{s.first_name}"
  end

  def datepicker_input(form, field)
    content_tag :td, data: { :provide => 'datepicker', 'date-format' => 'yyyy-mm-dd', 'date-autoclose' => 'true' } do
      form.text_field field, class: 'form-control', placeholder: 'YYYY-MM-DD'
    end
  end
end
