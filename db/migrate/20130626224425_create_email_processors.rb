class CreateEmailProcessors < ActiveRecord::Migration[4.2]
  def change
    create_table :email_processors do |t|

      t.timestamps
    end
  end
end
