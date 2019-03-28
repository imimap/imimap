class RenameStudentPrivateEmail < ActiveRecord::Migration[5.2]
  def change
     rename_column :students, :private_email, :private_email
  end
end
