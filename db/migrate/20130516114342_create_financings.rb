class CreateFinancings < ActiveRecord::Migration[4.2]
  def change
    create_table :financings do |t|

      t.timestamps
    end
  end
end
