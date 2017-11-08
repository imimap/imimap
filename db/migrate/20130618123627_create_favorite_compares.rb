class CreateFavoriteCompares < ActiveRecord::Migration[4.2]
  def change
    create_table :favorite_compares do |t|

      t.timestamps
    end
  end
end
