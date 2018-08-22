# frozen_string_literal: true

class RemoveProgrammingLanguageFromInternships < ActiveRecord::Migration[4.2]
  def change
    remove_column :internships, :programming_language
  end
end
