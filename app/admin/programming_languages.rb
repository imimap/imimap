# frozen_string_literal: true

ActiveAdmin.register ProgrammingLanguage do
  menu priority: 12
  permit_params %i[name]
  filter :name
  config.sort_order = 'id_asc'

  index do
    column :name
    column :internships do |n|
      link_to_list n.internships
    end
    actions
  end

  show do |language|
    attributes_table do
      row :id
      row :name

      row :internships do |_n|
        link_to_list language.internships
      end
    end
    active_admin_comments
  end
end
