class CreateSemesters < ActiveRecord::Migration[4.2]
  def change
    create_table :semesters do |t|
      t.string :semester

      t.timestamps
    end
  end
end
