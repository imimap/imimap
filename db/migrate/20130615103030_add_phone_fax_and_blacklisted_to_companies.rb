# frozen_string_literal: true

class AddPhoneFaxAndBlacklistedToCompanies < ActiveRecord::Migration[4.2]
  def change
    add_column :companies, :phone, :string
    add_column :companies, :fax, :string
    add_column :companies, :blacklisted, :boolean, default: false
  end
end
