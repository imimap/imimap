# frozen_string_literal: true
ActiveAdmin.register Semester do
  filter :name

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

  show do |semester|
    attributes_table do
      row :id
      row :name
      row :internships do | n |
        count = semester.internships.count
        "Total: #{count}"
      end
      row :internships do |n|
        a = semester.internships
        links = a.map do | internship |
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
