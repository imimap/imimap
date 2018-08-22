# frozen_string_literal: true

class AddReportToInternship < ActiveRecord::Migration[4.2]
  def change
    add_column :internships, :internship_report, :string
  end
end
