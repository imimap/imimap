# frozen_string_literal: true

class CreateReadingProf < ActiveRecord::Migration[4.2]
  def change
    create_table :reading_profs do |t|
      t.string :name

      t.timestamps
    end
  end
end
