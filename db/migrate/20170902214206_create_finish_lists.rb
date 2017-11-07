class CreateFinishLists < ActiveRecord::Migration
  def change
    create_table :finish_lists do |t|
      t.integer :user_id
      t.integer :internship_id

      t.timestamps null: false
    end
  end
end