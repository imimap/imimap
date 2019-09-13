# frozen_string_literal: true

ActiveAdmin.register CompleteInternship do
  menu parent: 'internship_admin', priority: 1
  permit_params CompleteInternshipsController.permitted_params
  filter :passed
  filter :student

  index do
    column :student do |ci|
      student = ci.student
      link_to student.name, admin_student_path(student.id)
    end
    column :internships do |ci|
      link_to_list ci.internships
    end
    bulk_params = CompleteInternshipsController.permitted_params.clone
    bulk_params.delete(:semester)
    column :semester do |ci|
      s = ci.semester
      link_to s.name, admin_semester_path(s.id) unless s.nil?
    end
    CompleteInternshipsController.permitted_params.each do |p|
      column p
    end
    actions
  end

  form do |f|
    bulk_params = CompleteInternshipsController.permitted_params.clone

    inputs 'CompleteInternship' do
      f.input :student_id,
              as: :select,
              collection: Student
                .order(:last_name)
                .collect { |s| [student_selector(student: s), s.id] }
      bulk_params.delete(:student_id)

      f.input :semester_id,
              label: 'Semester',
              as: :select,
              collection: Semester.order(:name)
                                  .collect { |s| [s.name, s.id] }
      bulk_params.delete(:semester_id)
      bulk_params.each do |field|
        f.input field
      end
      f.actions
    end
  end
end
