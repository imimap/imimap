class RenameInternshipIdToReadListId < ActiveRecord::Migration
  def change
    rename_column :finish_reads, :read_list_id, :internship_id
  end
end
