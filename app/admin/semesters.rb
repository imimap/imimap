# frozen_string_literal: true

ActiveAdmin.register Semester do
  permit_params %i[name]
  filter :name

  index do
    column :name
    column :internships do |n|
      a = n.internships.map(&:id)
      # TBD: created Issue
      # Fix little non-ruby/non-rails things in ActiveAdmin #229
      str = ''
      a.each do |x|
        str += link_to x, "/admin/internships/#{x}"
      end
      str.html_safe
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
        a = semester.internships
        links = a.map do |internship|
          internship_id = internship.id
          link_to internship_id, "/admin/internships/#{internship_id}"
        end
        links.join(', ').html_safe
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
