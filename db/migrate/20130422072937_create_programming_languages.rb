# frozen_string_literal: true

class CreateProgrammingLanguages < ActiveRecord::Migration[4.2]
  def change
    create_table :programming_languages do |t|
      t.string :name

      t.timestamps
    end
  end
end
