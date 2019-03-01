# frozen_string_literal: true

class DropQuicksearch < ActiveRecord::Migration[5.2]
  def up
    drop_table :quicksearches
  end

  def down
    create_table :quicksearches
  end
end
