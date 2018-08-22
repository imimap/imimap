# frozen_string_literal: true

class AddCompareboxToFavorite < ActiveRecord::Migration[4.2]
  def change
    add_column :favorites, :comparebox, :boolean
  end
end
