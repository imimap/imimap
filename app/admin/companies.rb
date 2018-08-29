# frozen_string_literal: true

ActiveAdmin.register Company do
  permit_params CompaniesController.permitted_params
  filter :internships_student_enrolment_number, as: :select, collection: proc { Student.pluck(:enrolment_number) }, label: 'Matrikel'
  filter :name
  filter :city
  filter :country

  index do
    column :internships do |n|
      a = n.internships.map(&:id)
      str = ''
      a.each do |x|
        str += link_to x, "/admin/internships/#{x}"
      end
      str.html_safe
    end
    CompaniesController.permitted_params.each do |a|
      column a
    end
    actions
  end
  show do |company|
    attributes_table do
      CompaniesController.permitted_params.each do |a|
        row a
      end
      row :company_addresses do |company|
        company.company_addresses.map do |ca|
          link_to(company_address_selector(company_address: ca), admin_company_address_path(ca))
        end.join(', ').html_safe
      end
      row :internships do |_n|
        a = company.internships.map(&:id)
        str = ''
        a.each do |x|
          str += link_to x, "/admin/internships/#{x}"
          str += '<br/>'
        end
        str.html_safe
      end
    end
  end
end
