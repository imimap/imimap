# frozen_string_literal: true

class AddRecommendToInternship < ActiveRecord::Migration[4.2]
  def change
    add_column :internships, :recommend, :boolean
  end
end
