class AddMailnotifToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :mailnotif, :boolean
  end
end
