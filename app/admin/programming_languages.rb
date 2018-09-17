# frozen_string_literal: true
include ApplicationHelper

ActiveAdmin.register ProgrammingLanguage do
  permit_params %i[name]
  filter :name
  config.sort_order = 'id_asc'

  index do
    column :name
    column :internships do |n|
      readable_links n.internships.map(&:id)
    end
    actions
  end

  show do |language|
    attributes_table do
      row :id
      row :name

      row :internships do |_n|
        readable_links language.internships.map(&:id)
      end
    end
    active_admin_comments
  end
end
