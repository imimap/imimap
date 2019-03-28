class AddPrivateemailToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :private_email, :string
  end
end
