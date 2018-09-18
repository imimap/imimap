# frozen_string_literal: true

ActiveAdmin.register Orientation do
  permit_params %i[name]
  filter :name

  index do
    column :name
    column :internships do |n|
      link_to_list n.internships
    end
    actions
  end

  show do |orientation|
    attributes_table do
      row :id
      row :name

      row :internships do |_n|
        link_to_list orientation.internships
      end
      active_admin_comments
    end
  end
end
