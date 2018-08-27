class AddCompanyAddressToInternship < ActiveRecord::Migration[5.1]
  def change
    add_reference :internships, :company_address, foreign_key: true
  end
end
