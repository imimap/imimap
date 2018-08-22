# frozen_string_literal: true

class ChangeRatingToDefaultOne < ActiveRecord::Migration[4.2]
  def change
    change_column :internships, :rating, :integer, default: 1
  end
end
