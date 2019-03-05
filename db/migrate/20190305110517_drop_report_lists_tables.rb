class DropReportListsTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :read_lists
    drop_table :finish_lists
  end
  def down
    create_table :read_lists
    create_table :finish_lists
  end
end
