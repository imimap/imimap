# frozen_string_literal: true

ActiveAdmin.register Student do
  permit_params StudentsController.permitted_params
  filter :enrolment_number, as: :select, collection: proc { Student.all.map(&:enrolment_number).uniq }, label: 'Matrikel'
  filter :last_name
  filter :first_name
  filter :email

  index do
    column :enrolment_number do |n|
      link_to n.enrolment_number, "/admin/students/#{n.id}"
    end
    column :internships do |n|
      a = n.internships.map(&:id)
      str = ''
      a.each do |x|
        str += link_to x, "/admin/internships/#{x}"
      end
      str.html_safe
    end
    column :last_name
    column :first_name
    column :birthday
    column :birthplace
    column :email
    actions
  end

  form do |f|
    f.inputs 'Students' do
      f.input :enrolment_number
      f.input :first_name
      f.input :last_name
      f.input :birthplace
      f.input :birthday, as: :datepicker,
                         datepicker_options: {
                           min_date: '1950-01-01',
                           max_date: '2020-01-01'
                         }
      f.input :email
    end
    f.actions
  end

  show do |student|
    attributes_table do
      row :enrolment_number
      row :last_name
      row :first_name
      row :birthday
      row :birthplace
      row :email

      row :internships do |_n|
        a = student.internships.map(&:id)
        str = ''
        a.each do |x|
          str += link_to x, "/admin/internships/#{x}"
        end
        str.html_safe
      end
    end
    active_admin_comments
  end
end
