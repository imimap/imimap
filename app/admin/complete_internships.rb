# frozen_string_literal: true

ActiveAdmin.register CompleteInternship do
  menu priority: 4
  permit_params CompleteInternshipsController.permitted_params
  filter :passed

  index do
    column :student do |ci|
      student = ci.student
      link_to student.name, admin_student_path(student.id)
    end
    column :internships do |ci|
      link_to_list ci.internships
    end
    CompleteInternshipsController.permitted_params.each do |p|
      column p
    end
    actions
  end
end
