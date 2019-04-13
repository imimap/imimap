# frozen_string_literal: true

ActiveAdmin.register Internship do
  show do |ad|
    attributes_table do
      row :student do |i|
        link_to_student(internship: i)
      end
      row :complete_internship
      row :company_v2
      row :start_date
      row :end_date
      # TBD clean this up
      row('weekCount') { ad.duration.weeks }
      row('weekValidation') do
        t("internship_duration_validation.#{ad.duration.validation}")
      end
      row :operational_area
      row :tasks
      row :supervisor_name
      row :supervisor_email
      row :programming_languages do |i|
        i.programming_languages.map(&:name).join(', ')
      end
      row :orientation
      row :semester
      row :registration_state
      row :payment_state
      row :contract_state
      row :report_state
      row :certificate_state
      row :reading_prof
      row :certificate_to_prof
      row :certificate_signed_by_prof
      row :certificate_signed_by_internship_officer
      row :internship_state
      row :passed?
      row :comment
    end
    active_admin_comments
  end
end
