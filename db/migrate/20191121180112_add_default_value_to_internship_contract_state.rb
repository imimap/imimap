class AddDefaultValueToInternshipContractState < ActiveRecord::Migration[6.0]
  def change
    change_column :internships, :contract_original, :boolean, :default => true
  end
end
