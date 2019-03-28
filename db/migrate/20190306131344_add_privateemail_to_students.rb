class AddPrivateemailToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :privateemail, :string
  end
end
