class CreateCompanies < ActiveRecord::Migration[4.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :address
      t.string :department
      t.integer :number_employees
      t.string :industry
      t.string :website

      t.timestamps
    end
  end
end
