# frozen_string_literal: true

class AddCompanyIdToInternships < ActiveRecord::Migration[4.2]
  def change
    add_column :internships, :company_id, :integer
  end
end
