# frozen_string_literal: true

class CreateDownloads < ActiveRecord::Migration[4.2]
  def change
    create_table :downloads, &:timestamps
  end
end
