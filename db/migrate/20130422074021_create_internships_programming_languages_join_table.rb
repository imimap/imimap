# frozen_string_literal: true

class CreateInternshipsProgrammingLanguagesJoinTable < ActiveRecord::Migration[4.2]
  def change
    create_table :internships_programming_languages, id: false do |t|
      t.integer :programming_language_id
      t.integer :internship_id
    end
  end
end
