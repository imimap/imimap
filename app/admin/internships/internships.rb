# frozen_string_literal: true

ActiveAdmin.register Internship do
  menu parent: 'internship_admin', priority: 2
  permit_params(*InternshipsController.permitted_params)
  filter :student_enrolment_number,
         as: :select,
         collection: proc { Student.all.map(&:enrolment_number).uniq },
         label: 'Matrikel'
  filter :reading_prof
  filter :semester
  filter :internship_state
  # see https://activeadmin.info/3-index-pages.html
  filter :certificate_signed_by_internship_officer_blank,
         as: :boolean,
         label: 'not signed'

  index do
    column(:id) { |i| link_to i.id, admin_internship_path(i.id) }

    column :student do |i|
      link_to_student(internship: i)
    end
    column :complete_internship do |i|
      unless i.complete_internship.nil?
        link_to(i.complete_internship.id,
                admin_complete_internship_path(i.complete_internship_id),
                id: link_id(i.complete_internship))
        # id: "CS_#{i.complete_internship_id}")
      end
    end
    column :company_v2
    column :semester
    column :approved?
    column :passed?
    column :internship_state
    column :report_state
    column :certificate_state
    column :certificate_to_prof
    column :certificate_signed_by_prof
    column :certificate_signed_by_internship_officer
    column :reading_prof
    actions
  end
end
