# frozen_string_literal: true

class AddCompanyIdToLocation < ActiveRecord::Migration[4.2]
  def change
    add_column :locations, :company_id, :integer
  end
end
