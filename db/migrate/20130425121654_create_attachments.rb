# frozen_string_literal: true

class CreateAttachments < ActiveRecord::Migration[4.2]
  def change
    create_table :attachments do |t|
      t.text :description
      t.string :file
      t.references :attachable, polymorphic: true

      t.timestamps
    end
    add_index :attachments, :attachable_id
  end
end
