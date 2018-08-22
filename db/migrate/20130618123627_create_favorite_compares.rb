# frozen_string_literal: true

class CreateFavoriteCompares < ActiveRecord::Migration[4.2]
  def change
    create_table :favorite_compares, &:timestamps
  end
end
