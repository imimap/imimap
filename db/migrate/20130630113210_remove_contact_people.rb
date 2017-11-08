class RemoveContactPeople < ActiveRecord::Migration[4.2]
  def change
    drop_table :contact_people
  end
end
