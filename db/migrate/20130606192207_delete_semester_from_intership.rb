# frozen_string_literal: true

class DeleteSemesterFromIntership < ActiveRecord::Migration[4.2]
  def change
    remove_column :internships, :semester
  end
end
