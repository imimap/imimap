# frozen_string_literal: true

class CreateCertificateStates < ActiveRecord::Migration[4.2]
  def change
    create_table :certificate_states do |t|
      t.string :name
      t.string :name_de

      t.timestamps
    end
  end
end
