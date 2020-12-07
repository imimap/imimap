# frozen_string_literal: true

ActiveAdmin.register Postponement do
  menu parent: 'internship_admin', priority: 1
  permit_params PostponementsController.permitted_params

  index do
    selectable_column
    column :id
    column :student
    column :semester
    column :semester_of_study
    column :reasons
    column :placed_at
    column :approved_at
    column :approved_by
    column :created_at
    column :updated_at
    actions
    column :approve do |postponement|
      link_to t('postponements.approve'),
              approve_postponement_path(postponement)
    end
  end

  show do |postponement|
    attributes_table do
      row :student do
        link_to postponement.student.name || postponement.student.email,
                admin_student_path(postponement.student_id)
      end
      row :semester
      row :semester_of_study
      row :reasons
      row :placed_at
      row :approved_at
      row :approved_by
      if postponement.approved_at.nil?
        row :approve do
          button_to t('postponements.approve'),
                    approve_postponement_path(postponement),
                    params: { admin: true },
                    method: :get
        end
      end
    end
    active_admin_comments
  end
end
