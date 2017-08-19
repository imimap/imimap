class CreateReads < ActiveRecord::Migration
  def change
    create_table :reads do |t|
      t.integer :user_id
      t.integer :internship_id

      t.timestamps null: false
    end
  end
end
