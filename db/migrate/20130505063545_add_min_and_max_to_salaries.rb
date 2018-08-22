# frozen_string_literal: true

class AddMinAndMaxToSalaries < ActiveRecord::Migration[4.2]
  def change
    add_column :salaries, :min_amount, :integer
    add_column :salaries, :max_amount, :integer
  end
end
