class CreateCompleteInternships < ActiveRecord::Migration[5.2]
  def change
    create_table :complete_internships do |t|
      t.string :semester
      t.integer :semester_of_study
      t.boolean :aep
      t.boolean :passed

      t.timestamps
    end
  end
end
