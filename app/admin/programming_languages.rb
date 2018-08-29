# frozen_string_literal: true

ActiveAdmin.register ProgrammingLanguage do
  permit_params %i[name]
  filter :name
  config.sort_order = 'id_asc'

  index do
    column :name
    column :internships do |n|
      a = n.internships.map(&:id)
      str = ''
      a.each do |x|
        str += link_to x, "/admin/internships/#{x}"
      end
      str.html_safe
    end
    actions
  end

  show do |language|
    attributes_table do
      row :id
      row :name

      row :internships do |_n|
        a = language.internships.map(&:id)
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
