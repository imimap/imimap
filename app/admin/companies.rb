# frozen_string_literal: true

ActiveAdmin.register Company do
  menu priority: 4
  permit_params CompaniesController.permitted_params
  filter :internships_student_enrolment_number,
         as: :select,
         collection: proc { Student.pluck(:enrolment_number) },
         label: 'Matrikel'
  filter :name

  index do
    column :internships do |n|
      link_to_list n.internships
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
      row :company_addresses do |a_company|
        a_company.company_addresses.map do |ca|
          link_to(company_address_selector(company_address: ca),
                  admin_company_address_path(ca))
        end.join(', ').html_safe
      end
      row :internships do |_n|
        link_to_list company.internships
      end
    end
  end
end
