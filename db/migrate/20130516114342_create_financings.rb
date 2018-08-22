# frozen_string_literal: true

class CreateFinancings < ActiveRecord::Migration[4.2]
  def change
    create_table :financings, &:timestamps
  end
end
