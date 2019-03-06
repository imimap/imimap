# frozen_string_literal: true

ActiveAdmin.register CompleteInternship do
  menu priority: 4
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
end
