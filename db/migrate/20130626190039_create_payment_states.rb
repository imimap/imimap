# frozen_string_literal: true

class CreatePaymentStates < ActiveRecord::Migration[4.2]
  def change
    create_table :payment_states do |t|
      t.string :name
      t.string :name_de

      t.timestamps
    end
  end
end
