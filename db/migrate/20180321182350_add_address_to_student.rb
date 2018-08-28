# frozen_string_literal: true

class AddAddressToStudent < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :city, :string
    add_column :students, :street, :string
    add_column :students, :zip, :string
    add_column :students, :phone, :string
  end
end
