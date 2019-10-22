class AddDefaultsForAepPassedInCompleteInternship < ActiveRecord::Migration[6.0]
  def change
    change_column :complete_internships, :aep, :boolean, default: false
    change_column :complete_internships, :passed, :boolean, default: false
  end
end
