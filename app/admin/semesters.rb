# frozen_string_literal: true

ActiveAdmin.register Semester do
  menu priority: 9
  permit_params %i[name]
  filter :name

  index do
    column :name
    column :internships do |n|
      link_to_list n.internships
    end
    actions
  end

  show do |semester|
    attributes_table do
      row :id
      row :name
      row :internships do |_n|
        count = semester.internships.count
        "Total: #{count}"
      end
      row :internships do |_n|
        link_to_list semester.internships
      end
    end
    active_admin_comments
  end

  controller do
    def semester_params
      params.require(:semester).permit(:name)
    end
  end
end
