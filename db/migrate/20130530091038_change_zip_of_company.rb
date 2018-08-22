# frozen_string_literal: true

class ChangeZipOfCompany < ActiveRecord::Migration[4.2]
  def change
    change_column :companies, :zip, :string
  end
end
