# frozen_string_literal: true

class DropSalary < ActiveRecord::Migration[4.2]
  drop_table :salaries
end
