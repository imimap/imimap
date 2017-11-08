class AddImportIdToStudents < ActiveRecord::Migration[4.2]
  def change
    add_column :students, :import_id, :integer
  end
end
