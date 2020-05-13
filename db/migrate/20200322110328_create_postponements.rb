class CreatePostponements < ActiveRecord::Migration[6.0]
  def change
    create_table :postponements do |t|
      t.references :student, foreign_key: true
      t.references :semester, foreign_key: true
      t.integer :semester_of_study
      t.text :reasons
      t.datetime :placed_at
      t.datetime :approved_at
      t.references :approved_by, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
