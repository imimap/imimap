class RenameStudentPrivateEmail < ActiveRecord::Migration[5.2]
  def change
     rename_column :students, :privateemail, :private_email
  end
end
