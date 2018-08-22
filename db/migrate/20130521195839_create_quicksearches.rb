# frozen_string_literal: true

class CreateQuicksearches < ActiveRecord::Migration[4.2]
  def change
    create_table :quicksearches, &:timestamps
  end
end
