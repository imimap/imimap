# frozen_string_literal: true

ActiveAdmin.register ReadingProf do
  permit_params %i[name]
  filter :name

  index do
    column :name
    column :internships do |n|
      readable_links n.internships.map(&:id)
    end
    actions
  end

  show do |prof|
    attributes_table do
      row :id
      row :name

      row :internships do |_n|
        readable_links prof.internships.map(&:id)
      end
    end
    active_admin_comments
  end
end
