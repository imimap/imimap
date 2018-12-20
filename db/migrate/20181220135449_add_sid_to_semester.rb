class AddSidToSemester < ActiveRecord::Migration[5.2]
  def change
    add_column :semesters, :sid, :decimal
  end
end
