# frozen_string_literal: true

class ChangeSemesterToName < ActiveRecord::Migration[4.2]
  def change
    rename_column :semesters, :semester, :name
  end
end
