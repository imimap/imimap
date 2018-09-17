# frozen_string_literal: true

ActiveAdmin.register Orientation do
  permit_params %i[name]
  filter :name

  index do
    column :name
    column :internships do |n|
      readable_links n.internships.map(&:id)
    end
    actions
  end

  show do |orientation|
    attributes_table do
      row :id
      row :name

      row :internships do |_n|
        readable_links orientation.internships.map(&:id)
      end
      active_admin_comments
    end
  end
end
