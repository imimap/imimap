class SetDefaultForReportStateId < ActiveRecord::Migration[4.2]
  def up
    change_column_default(:internships, :report_state_id, 1)
  end

  def down
    change_column_default(:internships, :report_state_id, nil)
  end
end
