# frozen_string_literal: true

class CreateEmailProcessors < ActiveRecord::Migration[4.2]
  def change
    create_table :email_processors, &:timestamps
  end
end
