# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[4.2]
  def change
    create_table :students do |t|
      t.string :matrikelNr
      t.string :last_name
      t.string :first_name
      t.date :birthday
      t.string :birthplace
      t.string :email

      t.timestamps
    end
  end
end
