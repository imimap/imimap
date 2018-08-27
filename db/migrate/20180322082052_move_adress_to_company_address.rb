class MoveAdressToCompanyAddress < ActiveRecord::Migration[5.1]
  def change
    Company.all.each do |c|
      company_addresses = CompanyAddress.new(
        :company_id => c.id,
        :city => c.city,
        :country => c.country,
        :street => c.street,
        :zip => c.zip,
        :phone => c.phone,
        :fax => c.fax
      )
      company_addresses.save!
    end
    remove_column :companies, :city, :string
    remove_column :companies, :country, :string
    remove_column :companies, :street, :string
    remove_column :companies, :zip, :string
    remove_column :companies, :phone, :string
    remove_column :companies, :fax

  end
end
