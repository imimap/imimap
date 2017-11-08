class CreateContactPeople < ActiveRecord::Migration[4.2]
  def change
    create_table :contact_people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.integer :company_id

      t.timestamps
    end
  end
end
