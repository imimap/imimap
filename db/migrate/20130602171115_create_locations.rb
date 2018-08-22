# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[4.2]
  def change
    create_table :locations do |t|
      t.string :street
      t.string :zip
      t.string :country
      t.string :city

      t.timestamps
    end
  end
end
