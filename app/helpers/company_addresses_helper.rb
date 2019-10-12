# frozen_string_literal: true

# Methods for the CompanyAddresses Views
module CompanyAddressesHelper
  def company_address_selector(company_address:)
    name = company_address.company.name
    street = company_address.street
    city = company_address.city
    country = company_address.country
    "#{name}, #{street}, #{city}, #{country}"
  end

  def find_internship_with_company_address
    internships = Internship.accessible_by(current_ability)
    internships.find(
      params[:company_address][:internship_id]
    )
  end

  def find_internship
    @current_user.student
                 .complete_internship
                 .internships
                 .find(
                   params[:internship_id]
                 )
  end

  def redirect_to_ci(format)
    format.html do
      redirect_to complete_internship_path(
        @current_user.student.complete_internship
      ),
                  notice: 'Company Address was successfully created.'
    end
  end
end
