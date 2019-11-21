class AddContractStateToInternships < ActiveRecord::Migration[6.0]
  def change
    add_column :internships, :contract_original, :boolean
  end
end
