# frozen_string_literal: true

class AddMainLanguageToCompanies < ActiveRecord::Migration[4.2]
  def change
    add_column :companies, :main_language, :string
  end
end
