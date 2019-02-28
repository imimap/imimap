class DropQuicksearch < ActiveRecord::Migration[5.2]
  def change
    drop_table :quicksearches
  end
end
