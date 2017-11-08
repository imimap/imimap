class CreateOrientations < ActiveRecord::Migration[4.2]
  def change
    create_table :orientations do |t|
      t.string :name

      t.timestamps
    end
  end
end
