class AddSuperuserToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :superuser, :boolean, default: false
  end
end
