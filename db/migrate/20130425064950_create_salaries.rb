# frozen_string_literal: true

class CreateSalaries < ActiveRecord::Migration[4.2]
  def change
    create_table :salaries do |t|
      t.string :amount
      t.integer :order_id

      t.timestamps
    end
  end
end
