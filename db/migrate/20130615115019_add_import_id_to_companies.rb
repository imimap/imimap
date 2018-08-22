# frozen_string_literal: true

class AddImportIdToCompanies < ActiveRecord::Migration[4.2]
  def change
    add_column :companies, :import_id, :integer
  end
end
