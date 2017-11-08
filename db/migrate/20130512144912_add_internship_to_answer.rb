class AddInternshipToAnswer < ActiveRecord::Migration[4.2]
  def change
    add_column :answers, :internship_id, :integer
  end
end
