# frozen_string_literal: true

class RemoveRatingsFromInternship < ActiveRecord::Migration[4.2]
  def change
    remove_column :internships, :tasks_rating
    remove_column :internships, :training_rating
    remove_column :internships, :atmosphere_rating
    remove_column :internships, :supervision_rating
    remove_column :internships, :appreciation_rating
  end
end
