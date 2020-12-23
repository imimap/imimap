class CreateThrowAway < ActiveRecord::Migration[6.0]
  def change
    create_table :throw_aways do |t|
      t.string :name
    end
  end
end
