class CreateFavorites < ActiveRecord::Migration[4.2]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :internship_id

      t.timestamps
    end
  end
end
