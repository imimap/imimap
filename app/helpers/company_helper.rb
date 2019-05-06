# frozen_string_literal: true

# Methods for the Company Views
module CompanyHelper
  def exists(company)
    @comp = Company.find_by(name: company.name)
    if !@comp.nil?
      return true
    else return false
  end
end
end
